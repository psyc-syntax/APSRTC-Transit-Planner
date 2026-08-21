#include "marksAlgorithm.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_map>
#include <string>
#include <sstream>
#include <algorithm>
#include <cstring>
#include <unordered_set>
#include <mutex>
#include <utility>

using namespace std;

#pragma pack(push, 1)
struct BIndex { int32_t start; int32_t end; };
#pragma pack(pop)

#pragma pack(push, 1)
struct BEntry { int16_t placeId; int32_t oprsNo; int16_t depMin; int16_t seqNo; };
#pragma pack(pop)

#pragma pack(push, 1)
struct RIndex { int32_t start; int32_t end; };
#pragma pack(pop)

#pragma pack(push, 1)
struct REntry { int32_t oprsNo; int16_t toPlaceId; int16_t arrMin; int16_t seqNo; };
#pragma pack(pop)

// ============================================================
// State key now packs THREE fields instead of two:
//   [ origin departure (16 bits) | oprsNo (32 bits) | placeId (16 bits) ]
// "origin" = the minute this lineage boarded at the SOURCE. Every
// state descending from the same original departure carries the
// same origin tag, which is what lets us track each departure's
// best journey separately instead of merging them together.
// ============================================================
typedef int64_t S_Key;

static S_Key mkKey(int16_t place, int32_t oprsNo, int16_t origin)
{
    return (((int64_t)(uint16_t)origin) << 48)
        | (((int64_t)(uint32_t)oprsNo) << 16)
        | (uint16_t)place;
}
static int16_t S_KeyPlace(S_Key K) { return (int16_t)(K & 0xFFFF); }
static int32_t S_KeyOprs(S_Key K) { return (int32_t)((K >> 16) & 0xFFFFFFFFu); }
static int16_t S_KeyOrigin(S_Key K) { return (int16_t)((K >> 48) & 0xFFFF); }

// "Same physical stop, same departure lineage" — used for
// deduplication so different departures never get merged.
typedef int32_t SlotKey;
static SlotKey mkSlot(int16_t place, int16_t origin)
{
    return (((int32_t)(uint16_t)origin) << 16) | (uint16_t)place;
}

struct Candidate
{
    S_Key   parent;
    int16_t toPlace;
    int32_t oprsNo;
    int16_t origin;
    int16_t dep;
    int16_t arr;   // absolute arrival minute (can exceed 1440 for wrap)
};

// ------------------------------------------------------------
// Binary data loaded exactly once per process, kept resident.
// ------------------------------------------------------------
static vector<BEntry> B_arr;
static vector<BIndex> B_index;
static vector<REntry> R_arr;
static vector<RIndex> R_index;
static once_flag      g_loadFlag;
static bool           g_loadOk = false;

static void loadEngineDataOnce(string dataPath)
{
    string folder = dataPath;

    cout << "========== C++ FILE DEBUG ==========" << endl;
    cout << "Folder: " << folder << endl;

    string bArrPath   = folder + "/B_arr.bin";
    string rArrPath   = folder + "/R_arr.bin";
    string bIndexPath = folder + "/B_index.bin";
    string rIndexPath = folder + "/R_index.bin";

    cout << "B_arr path: " << bArrPath << endl;
    cout << "R_arr path: " << rArrPath << endl;
    cout << "B_index path: " << bIndexPath << endl;
    cout << "R_index path: " << rIndexPath << endl;

    ifstream b_arrfile(bArrPath, ios::binary);
    ifstream r_arrfile(rArrPath, ios::binary);
    ifstream b_indexfile(bIndexPath, ios::binary);
    ifstream r_indexfile(rIndexPath, ios::binary);

    cout << "B_arr opened: " << b_arrfile.is_open() << endl;
    cout << "R_arr opened: " << r_arrfile.is_open() << endl;
    cout << "B_index opened: " << b_indexfile.is_open() << endl;
    cout << "R_index opened: " << r_indexfile.is_open() << endl;
    if (!b_arrfile.is_open() || !r_arrfile.is_open() ||
        !b_indexfile.is_open() || !r_indexfile.is_open())
    {
        g_loadOk = false;
        return;
    }

    int n;

    b_arrfile.read((char *)&n, sizeof(n));
    B_arr.resize(n);
    b_arrfile.read((char *)B_arr.data(), (streamsize)(n * sizeof(BEntry)));

    b_indexfile.read((char *)&n, sizeof(n));
    B_index.resize(n);
    b_indexfile.read((char *)B_index.data(), (streamsize)(n * sizeof(BIndex)));

    r_arrfile.read((char *)&n, sizeof(n));
    R_arr.resize(n);
    r_arrfile.read((char *)R_arr.data(), (streamsize)(n * sizeof(REntry)));

    r_indexfile.read((char *)&n, sizeof(n));
    R_index.resize(n);
    r_indexfile.read((char *)R_index.data(), (streamsize)(n * sizeof(RIndex)));

    g_loadOk = true;
}

const char *_buildResult(
    int16_t src,
    const unordered_map<S_Key, S_Key> &prev,
    const unordered_map<S_Key, pair<int16_t, int16_t>> &timings,
    vector<pair<int16_t, S_Key>> &destKeys);

const char *marksAlgorithm(
    int16_t src,
    int16_t dest,
    int16_t st,
    int16_t end,
    int16_t est,
    const char* dbpath
)
{
    call_once(g_loadFlag, [&]() {
    loadEngineDataOnce(dbpath);
});
    if (!g_loadOk)
    {
        thread_local static string error = "Failed to load one or more engine .bin files";
        return error.c_str();
    }

    // MAX_ROUND is now a real cost lever, not just a safety cap — since
    // we no longer stop early, every extra round adds real work across
    // EVERY still-active departure lineage. 3 (direct + up to 2
    // transfers) is a sane default for a regional bus network; raise it
    // only if you actually need deeper transfer chains.
    const int16_t MAX_ROUND = 6;
    const int16_t B_BUFFER  = 5;
    const int16_t W_BUFFER  = 180;

    unordered_map<SlotKey, int16_t>                     earlySlot; // best arrival ever seen per (place, origin)
    unordered_map<S_Key, S_Key>                          prev;
    unordered_map<S_Key, pair<int16_t, int16_t>>         timings;   // {dep, arr}
    unordered_map<S_Key, unordered_set<int32_t>>         usedOprs;
    unordered_map<int16_t, pair<int16_t, S_Key>>         bestTripForOrigin;  // origin -> {arr, nKey at dest}
    bool dfound = false;
    bool dflag = false;

    S_Key stKey = mkKey(src, -1, st);   // -1 = sentinel "no bus, this is the start"
    timings[stKey] = {st, st};
    usedOprs[stKey] = {};

    vector<S_Key> curr = {stKey};

    for (int round = 1; round <= MAX_ROUND && !curr.empty(); round++)
    {
        vector<Candidate> candidates;
        if(dfound) break;
        if(dflag) dfound = true;

        // ---------------- Phase A: generate every reachable connection ----------------
        for (S_Key stop_Key : curr)
        {
            int16_t board_id = S_KeyPlace(stop_Key);
            int16_t curr_arr = timings[stop_Key].second;

            if (board_id < 0 || static_cast<size_t>(board_id) >= B_index.size())
                continue;

            const auto &parentUsed = usedOprs[stop_Key];

            int16_t ws = (round == 1) ? st  : static_cast<int16_t>(curr_arr + B_BUFFER);
            int16_t we = (round == 1) ? end : static_cast<int16_t>(curr_arr + W_BUFFER);

            int32_t b_idx_st  = B_index[board_id].start;
            int32_t b_idx_end = B_index[board_id].end;
            if (b_idx_st == -1 || b_idx_end == -1) continue;

            // -------- main (same-day) window --------
            int32_t low = b_idx_st, high = b_idx_end;
            while (low <= high)
            {
                int32_t mid = (low + high) / 2;
                if (B_arr[mid].depMin < ws) low = mid + 1;
                else high = mid - 1;
            }

            for (int32_t i = low; i <= b_idx_end; i++)
            {
                if (B_arr[i].depMin > we) break;

                int32_t curr_oprs = B_arr[i].oprsNo;
                int16_t curr_dep  = B_arr[i].depMin;
                int16_t curr_seq  = B_arr[i].seqNo;
                if (parentUsed.find(curr_oprs) != parentUsed.end()) continue;

                int32_t r_idx_st  = R_index[curr_oprs].start;
                int32_t r_idx_end = R_index[curr_oprs].end;
                if (r_idx_st == -1 || r_idx_end == -1) continue;

                int32_t rlow = r_idx_st, rhigh = r_idx_end;
                while (rlow <= rhigh)
                {
                    int32_t mid = (rlow + rhigh) / 2;
                    if (R_arr[mid].seqNo < curr_seq) rlow = mid + 1;
                    else rhigh = mid - 1;
                }

                // FIX: origin now correctly seeds from THIS trip's own
                // departure (round 1) or is inherited from the parent
                // lineage (round 2+) — never mixed across departures.
                int16_t origin = (round == 1) ? curr_dep : S_KeyOrigin(stop_Key);

                for (int32_t J = rlow; J <= r_idx_end; J++)
                {
                    const REntry &re = R_arr[J];
                    if (re.arrMin <= curr_dep) continue;

                    // FIX: elapsed time measured from THIS lineage's own
                    // origin departure, not the global window start —
                    // otherwise trips departing later in the window get
                    // wrongly pruned as if they'd already taken hours.
                    int16_t travel = static_cast<int16_t>(re.arrMin - origin);
                    if (travel < 0) travel += 1440;

                    candidates.push_back({stop_Key, re.toPlaceId, curr_oprs, origin, curr_dep, re.arrMin});
                }
            }

            // -------- midnight wrap (round 2+ only — round 1 never crosses midnight for you) --------
            if (round != 1 && we > 1440)
            {
                int16_t wrapped_we = static_cast<int16_t>(we - 1440);
                int32_t rawWs = static_cast<int32_t>(ws) - 1440;
                int16_t wrapped_ws = (rawWs > 0) ? static_cast<int16_t>(rawWs) : static_cast<int16_t>(0);

                int32_t wlow = b_idx_st, whigh = b_idx_end;
                while (wlow <= whigh)
                {
                    int32_t mid = (wlow + whigh) / 2;
                    if (B_arr[mid].depMin < wrapped_ws) wlow = mid + 1;
                    else whigh = mid - 1;
                }

                int16_t origin = S_KeyOrigin(stop_Key);

                for (int32_t i = wlow; i <= b_idx_end; i++)
                {
                    if (B_arr[i].depMin >= wrapped_we) break;

                    int32_t curr_oprs = B_arr[i].oprsNo;
                    int16_t curr_dep  = B_arr[i].depMin;
                    int16_t curr_seq  = B_arr[i].seqNo;
                    if (parentUsed.find(curr_oprs) != parentUsed.end()) continue;

                    int32_t r_idx_st  = R_index[curr_oprs].start;
                    int32_t r_idx_end = R_index[curr_oprs].end;
                    if (r_idx_st == -1 || r_idx_end == -1) continue;

                    int32_t rlow = r_idx_st, rhigh = r_idx_end;
                    while (rlow <= rhigh)
                    {
                        int32_t mid = (rlow + rhigh) / 2;
                        if (R_arr[mid].seqNo < curr_seq) rlow = mid + 1;
                        else rhigh = mid - 1;
                    }

                    for (int32_t k = rlow; k <= r_idx_end; k++)
                    {
                        const REntry &re = R_arr[k];
                        if (re.arrMin <= curr_dep) continue;

                        int16_t travel = static_cast<int16_t>(re.arrMin + 1440 - origin);

                        candidates.push_back({stop_Key, re.toPlaceId, curr_oprs, origin, curr_dep,
                                               static_cast<int16_t>(re.arrMin + 1440)});
                    }
                }
            }
        }

        // ---------------- Phase B: keep only the best candidate per (place, origin) ----------------
        unordered_map<SlotKey, size_t> bestIdxForSlot;
        for (size_t idx = 0; idx < candidates.size(); idx++)
        {
            const Candidate &c = candidates[idx];
            SlotKey slot = mkSlot(c.toPlace, c.origin);

            auto already = earlySlot.find(slot);
            if (already != earlySlot.end() && already->second <= c.arr)
                continue; // this lineage already has an equal-or-better arrival here

            auto it = bestIdxForSlot.find(slot);
            if (it == bestIdxForSlot.end() || candidates[it->second].arr > c.arr)
                bestIdxForSlot[slot] = idx;
        }

        vector<S_Key> nxt;
        nxt.reserve(bestIdxForSlot.size());

        for (auto &kv : bestIdxForSlot)
        {
            const Candidate &c = candidates[kv.second];
            S_Key nKey = mkKey(c.toPlace, c.oprsNo, c.origin);

            earlySlot[mkSlot(c.toPlace, c.origin)] = c.arr;
            prev[nKey] = c.parent;
            timings[nKey] = {c.dep, c.arr};
            usedOprs[nKey] = usedOprs[c.parent];
            usedOprs[nKey].insert(c.oprsNo);
            nxt.push_back(nKey);

            // FIX: only ONE best trip is kept per origin, updated here as
            // better connections are found across rounds — no duplicate
            // or stale entries make it into the final output.
            if (c.toPlace == dest)
            {
                auto exist = bestTripForOrigin.find(c.origin);
                if (exist == bestTripForOrigin.end() || c.arr < exist->second.first)
                    bestTripForOrigin[c.origin] = {c.arr, nKey};
                dflag = true;
            }
        }

        curr = move(nxt);
    }

    // Collapse to exactly one result per distinct departure time, in
    // departure order — this IS your "how many total trips are
    // available, that many we want" list.
    vector<pair<int16_t, S_Key>> destKeys;
    destKeys.reserve(bestTripForOrigin.size());
    for (auto &kv : bestTripForOrigin)
        destKeys.push_back({kv.second.first, kv.second.second});

    sort(destKeys.begin(), destKeys.end(),
         [](const pair<int16_t, S_Key> &a, const pair<int16_t, S_Key> &b)
         { return S_KeyOrigin(a.second) < S_KeyOrigin(b.second); });

    return _buildResult(src, prev, timings, destKeys);
}

const char *_buildResult(
    int16_t src,
    const unordered_map<S_Key, S_Key> &prev,
    const unordered_map<S_Key, pair<int16_t, int16_t>> &timings,
    vector<pair<int16_t, S_Key>> &destKeys)
{
    vector<string> result;

    for (auto &destPair : destKeys)
    {
        S_Key currKey = destPair.second;
        vector<S_Key> path;
        bool reached_src = false;

        while (true)
        {
            path.push_back(currKey);
            if (S_KeyPlace(currKey) == src) { reached_src = true; break; }
            if (prev.find(currKey) == prev.end()) break;
            currKey = prev.at(currKey);
        }

        if (!reached_src) continue;

        reverse(path.begin(), path.end());

        ostringstream trip;
        trip << "[";
        for (size_t i = 0; i < path.size(); i++)
        {
            S_Key key = path[i];
            if (timings.find(key) == timings.end()) continue;
            auto time = timings.at(key);

            trip << "{";
            trip << "\"placeId\":" << S_KeyPlace(key) << ",";
            trip << "\"oprsNo\":" << S_KeyOprs(key) << ",";
            trip << "\"dep\":" << time.first << ",";
            trip << "\"arr\":" << time.second;
            trip << "}";
            if (i != path.size() - 1) trip << ",";
        }
        trip << "]";
        result.push_back(trip.str());
    }

    ostringstream arr;
    arr << "[";
    for (size_t i = 0; i < result.size(); i++)
    {
        arr << result[i];
        if (i != result.size() - 1) arr << ",";
    }
    arr << "]";

    thread_local static string output;
    output = arr.str();
    return output.c_str();
}

void freeMarksResult(const char *ptr)
{
    free(const_cast<char *>(ptr));
}

static string _buildResultJson(
    int16_t src,
    const unordered_map<S_Key, S_Key> &prev,
    const unordered_map<S_Key, pair<int16_t, int16_t>> &timings,
    vector<pair<int16_t, S_Key>> &destKeys)
{
    vector<string> result;

    for (auto &destPair : destKeys)
    {
        S_Key currKey = destPair.second;
        vector<S_Key> path;
        bool reached_src = false;

        while (true)
        {
            path.push_back(currKey);
            if (S_KeyPlace(currKey) == src) { reached_src = true; break; }
            if (prev.find(currKey) == prev.end()) break;
            currKey = prev.at(currKey);
        }

        if (!reached_src) continue;

        reverse(path.begin(), path.end());

        ostringstream trip;
        trip << "[";
        for (size_t i = 0; i < path.size(); i++)
        {
            S_Key key = path[i];
            if (timings.find(key) == timings.end()) continue;
            auto time = timings.at(key);

            trip << "{";
            trip << "\"placeId\":" << S_KeyPlace(key) << ",";
            trip << "\"oprsNo\":" << S_KeyOprs(key) << ",";
            trip << "\"dep\":" << time.first << ",";
            trip << "\"arr\":" << time.second;
            trip << "}";
            if (i != path.size() - 1) trip << ",";
        }
        trip << "]";
        result.push_back(trip.str());
    }

    ostringstream arr;
    arr << "[";
    for (size_t i = 0; i < result.size(); i++)
    {
        arr << result[i];
        if (i != result.size() - 1) arr << ",";
    }
    arr << "]";

    return arr.str();
}