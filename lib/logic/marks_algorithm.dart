import 'dart:math';
import 'dart:isolate';

import 'package:planner_demo/models/app_data.dart';
import 'package:sqlite3/sqlite3.dart' as ffi;
import 'package:planner_demo/helpers/database_helper.dart';

// =========================================================
//
//   MARKS ALGORITHM — ROUND-BASED (RAPTOR-style)
//   MARK — Transit Intelligence
//
// =========================================================

class Pair<K, V> {
  final K key;
  final V value;
  Pair(this.key, this.value);
}



// =========================================================
// MAIN ENTRY POINT (Runs on Main UI Thread)
// =========================================================
Future<Result> marksAlgorithm(
  String sourcePlaceId,
  String destinationPlaceId,
  int    startTime,
) async {
  if (sourcePlaceId.isEmpty || destinationPlaceId.isEmpty) {
    return Result([], 0);
  }

  // 1. Get the actual file path from sqflite (safely on the main thread)
  final dbPath = await DatabaseHelper().getDatabaseFilePath();

  print("MARKS: $sourcePlaceId → $destinationPlaceId at $startTime (Spawning Isolate)");

  // 2. Spawn a background Isolate to prevent UI freezing
  return await Isolate.run(() {
    // 3. Open the database synchronously in the background using sqlite3 FFI
    final db = ffi.sqlite3.open(dbPath);
    
    try {
      // 4. Run the high-speed synchronous algorithm
      return _runMarksAlgorithmSync(db, sourcePlaceId, destinationPlaceId, startTime);
    } finally {
      // 5. CRITICAL: Always dispose of the background database connection
      db.dispose();
    }
  });
}

// =========================================================
// SYNCHRONOUS ROUTING ENGINE (Runs on Background Isolate)
// =========================================================
Result _runMarksAlgorithmSync(
  ffi.Database db, 
  String sourcePlaceId, 
  String destinationPlaceId, 
  int startTime
) {
  // ── Config ─────────────────────────────────────────────
  const int maxRounds      = 6;
  const int maxWaitMinutes = 180;
  int boardingBuffer = 5;
  int destinationFoundState = 0;

  // ── State ──────────────────────────────────────────────
  Map<String, int>            earliestArrival = {};
  Map<String, String>         previous        = {};
  Map<String, Pair<int, int>> stopTimes       = {};

  /// global pruning map, keyed by PLACE ONLY
  Map<String, int> globalBest = {sourcePlaceId: startTime};

  /// buses already ridden to reach each state — bounded by
  Map<String, Set<String>> usedOprsAtStop = {};

  final String startKey = "$sourcePlaceId|null";
  earliestArrival[startKey] = startTime;
  usedOprsAtStop[startKey]  = <String>{};

  List<String> currentRoundStops = [startKey];
  
  // =========================================================
  // MAIN LOOP — each round = one bus taken
  // =========================================================
  for (int round = 1; round <= maxRounds; round++) {
    if (currentRoundStops.isEmpty) break;
    if (destinationFoundState > 1 ) break;

    print("Round $round | exploring ${currentRoundStops.length} stop(s)");

    List<String> nextRoundStops = [];

    for (final String stopKeyNow in currentRoundStops) {
      final String boardingStop = stopKeyNow.split('|')[0];
      final int    currArr      = earliestArrival[stopKeyNow] ?? startTime;
      
      Set<String> usedSoFar = {};
      if (usedOprsAtStop.containsKey(stopKeyNow)){
        usedSoFar = usedOprsAtStop[stopKeyNow]!;
      }

      final List<String> usedList = usedSoFar.toList();
      String exclusionClause = "";

      if (usedList.isNotEmpty){
        exclusionClause = "AND e1.oprsNo NOT IN(";
        for(int i = 0; i < usedList.length; i++){
          exclusionClause += "?";
          if(i != usedList.length - 1){
            exclusionClause += ",";
          }
        }
        exclusionClause += ")";
      }

      List<Object?> params = [];
      params.add(boardingStop);
      params.add(currArr + (round != 1 ? boardingBuffer : 0));
      params.add(currArr + maxWaitMinutes);

      for (int i = 0; i < usedList.length; i++){
        params.add(usedList[i]);
      }

      // Synchronous Query - extremely fast execution
      ffi.ResultSet reachable = db.select('''
        SELECT
            e2.to_placeId        AS to_placeId,
            e2.oprsNo            AS oprsNo,
            e1.dep_min           AS dep_min,
            MIN(e2.arr_min)      AS arr_min
        FROM edges e1
        JOIN edges e2
            ON  e1.oprsNo     = e2.oprsNo
            AND e2.from_seqNo >= e1.from_seqNo
        WHERE e1.from_placeId = ?
          AND e1.dep_min BETWEEN ? AND ?
          $exclusionClause
        GROUP BY e2.to_placeId
        ORDER BY arr_min ASC
      ''', params);

      if (currArr + maxWaitMinutes > 1440){
        params[0] = boardingStop;
        params[1] = max(0, currArr - 1440) + boardingBuffer;
        params[2] = max(currArr - 1440 + maxWaitMinutes, 390);

        final ffi.ResultSet midNightReachable = db.select('''
        SELECT
            e2.to_placeId        AS to_placeId,
            e2.oprsNo            AS oprsNo,
            e1.dep_min + 1440    AS dep_min,
            MIN(e2.arr_min) + 1440   AS arr_min
        FROM edges e1
        JOIN edges e2
            ON  e1.oprsNo     = e2.oprsNo
            AND e2.from_seqNo >= e1.from_seqNo
        WHERE e1.from_placeId = ?
          AND e1.dep_min BETWEEN ? AND ?
          $exclusionClause
        GROUP BY e2.to_placeId
        ORDER BY arr_min ASC
      ''', params);

        // Convert ResultSets to lists to merge them easily
        var mergedReachable = [...reachable, ...midNightReachable];
        _processReachableRows(mergedReachable, earliestArrival, previous, stopTimes, usedOprsAtStop, globalBest, nextRoundStops, stopKeyNow, usedSoFar);
      } else {
        _processReachableRows(reachable, earliestArrival, previous, stopTimes, usedOprsAtStop, globalBest, nextRoundStops, stopKeyNow, usedSoFar);
      }
    }

    print(
      "  Round $round done: ${nextRoundStops.length} stop(s) to expand next"
      " | dest=${globalBest[destinationPlaceId] ?? 'not yet'}",
    );

    if (globalBest.containsKey(destinationPlaceId)) {
      print("  ✅ Destination reached in round $round");
      destinationFoundState++;
      if(round >= 3) break;
    }

    if (nextRoundStops.isEmpty) break;
    currentRoundStops = nextRoundStops;
  }

  return _buildResultSync(
    sourcePlaceId,
    destinationPlaceId,
    startTime,
    previous,
    stopTimes,
    db,
  );
}

void _processReachableRows(
  Iterable<ffi.Row> reachable,
  Map<String, int> earliestArrival,
  Map<String, String> previous,
  Map<String, Pair<int, int>> stopTimes,
  Map<String, Set<String>> usedOprsAtStop,
  Map<String, int> globalBest,
  List<String> nextRoundStops,
  String stopKeyNow,
  Set<String> usedSoFar
) {
  for (final row in reachable) {
    final String? toPlaceId = row['to_placeId'] as String?;
    final String? oprsNo    = row['oprsNo']     as String?;
    final int?    dept      = row['dep_min']    as int?;
    final int?    arr       = row['arr_min']    as int?;

    if (toPlaceId == null || oprsNo == null ||
        dept == null || arr == null) continue;

    final String newKey = "$toPlaceId|$oprsNo";

    final bool isBetterForRoute =
        !earliestArrival.containsKey(newKey) ||
         arr < earliestArrival[newKey]!;

    if (!isBetterForRoute) continue;

    earliestArrival[newKey] = arr;
    previous[newKey]        = stopKeyNow;
    stopTimes[newKey]       = Pair(dept, arr);
    usedOprsAtStop[newKey]  = {...usedSoFar, oprsNo};

    final bool isBetterGlobally =
        !globalBest.containsKey(toPlaceId) ||
         arr < globalBest[toPlaceId]!;

    if (isBetterGlobally) {
      globalBest[toPlaceId] = arr;
      nextRoundStops.add(newKey);
    }
  }
}


// =========================================================
// BUILD RESULT (Synchronous Version with Inline Scoring)
// =========================================================
Result _buildResultSync(
  String sourcePlaceId,
  String destinationPlaceId,
  int    startTime,
  Map<String, String>         previous,
  Map<String, Pair<int, int>> stopTimes,
  ffi.Database db,
) {
  final List<String> destKeys = [];
  for (final key in stopTimes.keys) {
    if (key.startsWith("$destinationPlaceId|")) {
      destKeys.add(key);
    }
  }

  if (destKeys.isEmpty) {
    print("❌ No route found.");
    return Result([], 0);
  }

  // Scoring Weights
  const double waitTimeMultiplier = 1.5; 
  const double transferPenaltyMins = 45.0;

  List<PathStop> bestRawPath = [];
  double bestScore = double.infinity;
  int finalArrivalTime = 0;

  // Evaluate all routes that reached the destination
  for (final destKey in destKeys) {
    final List<PathStop> currentRawPath = [];
    String? currentKey = destKey;

    // 1. Reconstruct path backward
    while (currentKey != null) {
      final String placeId = currentKey.split('|')[0];
      final String oprsNo  = currentKey.split('|')[1];

      if (placeId == sourcePlaceId) {
        currentRawPath.insert(0, PathStop(
          placeId:     placeId,
          placeName:   '',
          arrivalTime: startTime,
          deptTime:    startTime,
          oprsNo:      '',
        ));
        break;
      }

      final Pair<int, int>? times = stopTimes[currentKey];
      if (times == null) break;

      currentRawPath.insert(0, PathStop(
        placeId:     placeId,
        placeName:   '',
        arrivalTime: times.value,
        deptTime:    times.key,
        oprsNo:      oprsNo,
        time: times.value - times.key
      ));

      currentKey = previous[currentKey];
    }

    // 2. Shift deptTime: each stop shows the NEXT leg's boarding time
    for (int i = 0; i < currentRawPath.length - 1; i++) {
      currentRawPath[i] = PathStop(
        placeId:     currentRawPath[i].placeId,
        placeName:   currentRawPath[i].placeName,
        arrivalTime: currentRawPath[i].arrivalTime,
        deptTime:    currentRawPath[i + 1].deptTime,
        oprsNo:      currentRawPath[i + 1].oprsNo,
        time:        currentRawPath[i].time
      );
    }
    
    if (currentRawPath.isNotEmpty) {
      final last = currentRawPath.last;
      currentRawPath[currentRawPath.length - 1] = PathStop(
        placeId:     last.placeId,
        placeName:   last.placeName,
        arrivalTime: last.arrivalTime,
        deptTime:    last.arrivalTime,
        oprsNo:      last.oprsNo,
      );
    }

    // 3. Calculate metrics for this specific path
    int arrival = currentRawPath.last.arrivalTime;
    int totalTravelTime = arrival - startTime;
    if (totalTravelTime < 0) totalTravelTime += 1440; // Midnight wrap

    int totalWaitTime = 0;
    for (int i = 0; i < currentRawPath.length - 1; i++) {
      int wait = currentRawPath[i].deptTime - currentRawPath[i].arrivalTime;
      if (wait < 0) wait += 1440;
      totalWaitTime += wait;
    }

    int transfers = (currentRawPath.length - 2).clamp(0, 999);

    // 4. Apply the score formula
    double score = totalTravelTime + 
                  (totalWaitTime * waitTimeMultiplier) + 
                  (transfers * transferPenaltyMins);

    // Keep track of the lowest score
    if (score < bestScore) {
      bestScore = score;
      bestRawPath = currentRawPath;
      finalArrivalTime = arrival;
    }
  }

  print("🏆 Best Route Score: $bestScore | Arrival: $finalArrivalTime");

  // We now proceed with the single best route exactly as the old code did
  final List<PathStop> rawPath = bestRawPath;
  List<String> placeIds = [];
  List<String> oprsNoList = [];
  for (var p in rawPath) {
    if (!placeIds.contains(p.placeId)) {
      placeIds.add(p.placeId);
      oprsNoList.add(p.oprsNo);
    }
  }

  Map<String, String> nameLookup = {};
  Map<String, String> serviceTypeLookup = {};
  Map<String, String> vehicleNoLookup = {};
  Map<String, Map<String, String>> stopDetailsLookup = {};

  if (placeIds.isNotEmpty) {
    String placeholders = List.filled(placeIds.length, '?').join(',');
    
    final ffi.ResultSet rows = db.select(
      'SELECT * FROM place_master WHERE placeId IN ($placeholders)',
      placeIds,
    );

    for (final row in rows) {
      final id = row['placeId'].toString();
      nameLookup[id] = row['placeName']?.toString() ?? 'Unknown';

      stopDetailsLookup[id] = {
        "placeId" : row['placeId'].toString(),
        "placeName" :  row['placeName']?.toString() ?? 'Unknown',
        "pincode" : row['pincode']?.toString() ?? '',
        "address" : row['address']?.toString() ?? '',
        'latitude' : row['latitude']?.toString() ?? '',
        'longitude' : row['longitude']?.toString() ?? '',
        'district' : row['district']?.toString() ?? '',
      };
    }
  }

  if (oprsNoList.isNotEmpty) {
    final placeholders = List.filled(oprsNoList.length, '?').join(',');
    final ffi.ResultSet serviceDetails = db.select('''
      SELECT oprsNo, vehicleNumber, serviceType
      FROM service_details
      WHERE oprsNo IN ($placeholders)
      ''', oprsNoList,
    );

    for (final row in serviceDetails) {
      final id = row['oprsNo'] as String;
      serviceTypeLookup[id] = row['serviceType']?.toString() ?? '';
      vehicleNoLookup[id] = row['vehicleNumber']?.toString() ?? '';
    }
  }

  final List<PathStop> path = [];

  for (int i = 0; i < rawPath.length; i++) {
    double distance = 0;
    int time = 0;

    if(i < rawPath.length - 1){
       time = (rawPath[i].deptTime) - (rawPath[i + 1].arrivalTime);
       int arrival = rawPath[i+ 1].arrivalTime;
       int dept = rawPath[i].deptTime;
      
      if(arrival < dept) {
        arrival += 1440;
      }
      time = arrival - dept;
      distance /= 2;
    }
    
    path.add(
      PathStop(
        placeId: rawPath[i].placeId,
        placeName: nameLookup[rawPath[i].placeId] ?? 'UNKNOWN',
        arrivalTime: rawPath[i].arrivalTime,
        deptTime: rawPath[i].deptTime,
        oprsNo: rawPath[i].oprsNo,
        distance: distance,
        time: time,
        serviceType: serviceTypeLookup[rawPath[i].oprsNo] ?? "UNKNOWN",
        vehicleNo: vehicleNoLookup[rawPath[i].oprsNo] ?? "UNKNOWN",
        stopDetails: stopDetailsLookup[rawPath[i].placeId]
      ),
    );
  }

  for (int i = 0; i < path.length; i++) {

    final s = path[i];

    print(

      "  [${i + 1}] ${s.placeName} (${s.placeId})"

      "  bus=${s.oprsNo.isEmpty ? 'source' : s.oprsNo}"

      "  board=${s.deptTime}  arrive=${s.arrivalTime} "

      " distance = ${s.distance}"

      "  time = ${s.time}"

    );

  }

  return Result(path, finalArrivalTime);
}