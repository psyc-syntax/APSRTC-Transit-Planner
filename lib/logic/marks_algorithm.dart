import 'package:planner_demo/helpers/database_helper.dart';

// =========================================================
//
//   MARKS ALGORITHM — ROUND-BASED (RAPTOR-style)
//   MARK — Transit Intelligence
//
// =========================================================
//
//  WHY NOT A REAL "oprs_found" TABLE
//
//  A persistent table would need to be cleared/rebuilt per
//  search, can't safely handle two searches running at once,
//  and the write cost per state is higher than what we'd save.
//
//  INSTEAD: dynamic NOT IN (...) built from the in-memory
//  used-bus set, bound as SQL parameters. SQLite excludes
//  those rows BEFORE joining/aggregating — no wasted I/O
//  across the Dart↔SQLite boundary, no wasted Dart iteration.
//
//  usedSoFar already contains the currently-ridden bus
//  (added when that state was created), so the old separate
//  "!= boardingOprs" param is now redundant and removed —
//  one NOT IN list covers everything.
//
// =========================================================


class Pair<K, V> {
  final K key;
  final V value;
  Pair(this.key, this.value);
}

class PathStop {
  final String placeId;
  final String placeName;
  final int    arrivalTime;
  final int    deptTime;
  final String oprsNo;

  PathStop({
    required this.placeId,
    required this.placeName,
    required this.arrivalTime,
    required this.deptTime,
    required this.oprsNo,
  });
}

class Result {
  final List<PathStop> path;
  final int            time;
  Result(this.path, this.time);
}


Future<Result> marksAlgorithm(
  String sourcePlaceId,
  String destinationPlaceId,
  int    startTime,
) async {

  if (sourcePlaceId.isEmpty || destinationPlaceId.isEmpty) {
    return Result([], 0);
  }

  final database = await DatabaseHelper().database;

  print("MARKS: $sourcePlaceId → $destinationPlaceId at $startTime");

  // ── Config ─────────────────────────────────────────────
  const int maxRounds      = 6;
  const int maxWaitMinutes = 240;
  const int boardingBuffer = 5;

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

    print("Round $round | exploring ${currentRoundStops.length} stop(s)");

    List<String> nextRoundStops = [];

    for (final String stopKeyNow in currentRoundStops) {

      final String boardingStop = stopKeyNow.split('|')[0];
      final int    currArr      = earliestArrival[stopKeyNow] ?? startTime;

      Set<String> usedSoFar = {};
      if(usedOprsAtStop.containsKey(stopKeyNow)){
        usedSoFar = usedOprsAtStop[stopKeyNow]!;
      }

      // ── Build dynamic exclusion clause ───────────────────
      // Empty usedSoFar at source → no clause, any bus eligible.
      // Otherwise excludes every bus already ridden this journey,
      // done at the SQL level so excluded routes never get
      // joined/aggregated or sent back to Dart at all.


      final List<String> usedList = usedSoFar.toList();
      



      String exclusionClause = "";

      if(usedList.isNotEmpty){
        exclusionClause = "AND e1.oprsNo NOT IN(";

        for(int i = 0; i < usedList.length; i++){
          exclusionClause += "?";

          if(i != usedList.length - 1){
            exclusionClause += ",";
          }


        }
        exclusionClause += ")";
      }

      List <Object> params = [];

      params.add(boardingStop);
      params.add(currArr + boardingBuffer);
      params.add(currArr + maxWaitMinutes);

      for(int i = 0; i < usedList.length; i++){
        params.add(usedList[i]);
      }

      final List<Map<String, dynamic>> reachable =
          await database.rawQuery('''
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

      // No client-side usedSoFar.contains(oprsNo) check needed —
      // SQL already excluded them before this point.

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

    print(
      "  Round $round done: ${nextRoundStops.length} stop(s) to expand next"
      " | dest=${globalBest[destinationPlaceId] ?? 'not yet'}",
    );

    if (globalBest.containsKey(destinationPlaceId)) {
      print("  ✅ Destination reached in round $round");
      break;
    }

    if (nextRoundStops.isEmpty) break;
    currentRoundStops = nextRoundStops;
  }

  return _buildResult(
    sourcePlaceId,
    destinationPlaceId,
    startTime,
    previous,
    stopTimes,
    database,
  );
}


// =========================================================
// BUILD RESULT — reconstruct path from destination back to source
// =========================================================

Future<Result> _buildResult(
  String sourcePlaceId,
  String destinationPlaceId,
  int    startTime,
  Map<String, String>         previous,
  Map<String, Pair<int, int>> stopTimes,
  dynamic database,
) async {

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

  String bestKey = destKeys.first;
  for (final key in destKeys) {
    if (stopTimes[key]!.value < stopTimes[bestKey]!.value) {
      bestKey = key;
    }
  }

  final List<PathStop> rawPath = [];
  String? currentKey = bestKey;

  while (currentKey != null) {

    final String placeId = currentKey.split('|')[0];
    final String oprsNo  = currentKey.split('|')[1];

    if (placeId == sourcePlaceId) {
      rawPath.insert(0, PathStop(
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

    rawPath.insert(0, PathStop(
      placeId:     placeId,
      placeName:   '',
      arrivalTime: times.value,
      deptTime:    times.key,
      oprsNo:      oprsNo,
    ));

    currentKey = previous[currentKey];
  }

  // shift deptTime: each stop shows the NEXT leg's boarding time
  for (int i = 0; i < rawPath.length - 1; i++) {
    rawPath[i] = PathStop(
      placeId:     rawPath[i].placeId,
      placeName:   rawPath[i].placeName,
      arrivalTime: rawPath[i].arrivalTime,
      deptTime:    rawPath[i + 1].deptTime,
      oprsNo:      rawPath[i].oprsNo,
    );
  }
  if (rawPath.isNotEmpty) {
    final last = rawPath.last;
    rawPath[rawPath.length - 1] = PathStop(
      placeId:     last.placeId,
      placeName:   last.placeName,
      arrivalTime: last.arrivalTime,
      deptTime:    last.arrivalTime,
      oprsNo:      last.oprsNo,
    );
  }

  // batch place name lookup
  // final List<String> placeIds = rawPath.map((p) => p.placeId).toList();

  List<String> placeIds = [];
  for (var p in rawPath) {
    if (!placeIds.contains(p.placeId)) {
      placeIds.add(p.placeId);
    }
  }

  Map<String, String> nameLookup = {};

  if (placeIds.isNotEmpty) {
    String placeholders = "";

    for (int i = 0; i < placeIds.length; i++) {
      placeholders += "?";
      if (i != placeIds.length - 1) {
        placeholders += ",";
      }
    }
    final List<Map<String, dynamic>> rows = await database.rawQuery(
      'SELECT placeId, placeName FROM place_master WHERE placeId IN ($placeholders)',
      placeIds,
    );
    for (final row in rows) {
      nameLookup[row['placeId'].toString()] = row['placeName']?.toString() ?? '';
    }
  }

  final List<PathStop> path = rawPath.map((p) => PathStop(
    placeId:     p.placeId,
    placeName:   nameLookup[p.placeId] ?? '',
    arrivalTime: p.arrivalTime,
    deptTime:    p.deptTime,
    oprsNo:      p.oprsNo,
  )).toList();

  print("Path: ${path.length} stop(s) | arrival=${stopTimes[bestKey]!.value}");

  
  for (int i = 0; i < path.length; i++) {
    final s = path[i];
    print(
      "  [${i + 1}] ${s.placeName} (${s.placeId})"
      "  bus=${s.oprsNo.isEmpty ? 'source' : s.oprsNo}"
      "  board=${s.deptTime}  arrive=${s.arrivalTime}",
    );
  }

  return Result(path, stopTimes[bestKey]!.value);
}







// import 'dart:collection';

// import 'package:collection/collection.dart';
// import 'package:path/path.dart';

// import 'package:planner_demo/helpers/database_helper.dart';

// // =========================================================
// //
// //   MARKS ALGORITHM — ROUND-BASED (RAPTOR-style)
// //   MARK — Transit Intelligence
// //
// // =========================================================
// //
// //  HOW ROUNDS WORK
// //
// //  Each round = one bus taken (one additional transfer).
// //  Within a round, you can travel the ENTIRE length
// //  of a route — not just one stop at a time.
// //
// //  Round 1:  Board any bus from source.
// //            Scan ALL stops on that route forward.
// //            Source reaches 20+ stops in round 1.
// //
// //  Round 2:  At any stop reached in round 1,
// //            board a DIFFERENT bus. Scan its stops.
// //            1 transfer covered.
// //
// //  Round 3, 4, 5: each = one more transfer.
// //
// //  5 rounds = 4 transfers. Covers any AP/Telangana journey.
// //
// //  KEY QUERY (does all the heavy lifting):
// //
// //    SELECT e2.to_placeId, MIN(e2.arr_min)
// //    FROM edges e1
// //    JOIN edges e2
// //        ON  e1.oprsNo = e2.oprsNo        -- same bus
// //        AND e2.from_seqNo >= e1.from_seqNo -- forward only
// //    WHERE e1.from_placeId = ?            -- boarding stop
// //      AND e1.dep_min BETWEEN ? AND ?     -- departs after arrival
// //    GROUP BY e2.to_placeId
// //
// //  One call per stop per round. Scans entire routes.
// //
// // =========================================================

// class Pair<K, V> {
//   final K key;
//   final V value;
//   Pair(this.key, this.value);
// }

// class PathStop {
//   final String placeId;
//   final String placeName;
//   final int arrivalTime;
//   final int deptTime;
//   final String oprsNo; // Added to track the bus route taken at this stop

//   PathStop({
//     required this.placeId,

//     required this.placeName,
//     required this.arrivalTime,
//     required this.deptTime,
//     required this.oprsNo,
//   });
// }

// class Result {
//   final List<PathStop> path;
//   final int time;
//   Result(this.path, this.time);
// }

// Future<Result> marksAlgorithm(
//   String sourcePlaceId,
//   String destinationPlaceId,
//   int startTime,
// ) async {
//   if (sourcePlaceId.isEmpty || destinationPlaceId.isEmpty) {
//     return Result([], 0);
//   }

//   final database = await DatabaseHelper().database;

//   print("MARKS: $sourcePlaceId → $destinationPlaceId at $startTime");

//   const int maxRounds = 6; // 5–6 covers any AP/Telangana journey
//   const int maxWaitMinutes = 1000; // max 4 hours wait for a connecting bus
//   const int boardingBuffer = 5;

//   // 5 min minimum boarding time

//   Map<String, String> previous = {};
//   Map<String, Pair<int, int>> stopTimes = {};
//   Map<String, int> earliestArrival = {};

//   String startKey = "$sourcePlaceId|null";
//   earliestArrival[startKey] = startTime;
//   List<String> currentRoundStops = [startKey];


//   for (int round = 1; round <= maxRounds; round++) {



//     List<String> nextRoundStops = [];
//     print("current round $round");
//     print("current round lenght ${currentRoundStops.length}.");


    

//     for (String stop in currentRoundStops) {


//       String boardingStop = stop.split('|')[0];

//       int currarr = earliestArrival[stop] ?? startTime;

//       final List<Map<String, dynamic>> reachable = await database.rawQuery(
//         '''
//         WITH best_arrival AS (
//           SELECT
//             e2.to_placeId,
//             MIN(e2.arr_min) AS arr_min
//           FROM edges e1
//           JOIN edges e2
//             ON e1.oprsNo = e2.oprsNo
//             AND e2.from_seqNo >= e1.from_seqNo
//           WHERE e1.from_placeId = ?
//             AND e1.dep_min BETWEEN ? AND ?
            
//           Group BY e2.to_placeId

//         )
//         SELECT
//             e1.from_placeId      AS from_placeId,
//             e2.to_placeId        AS to_placeId,
//             e2.oprsNo            AS oprsNo,
//             e1.dep_min           AS dep_min,
//             e2.arr_min           AS arr_min
//         FROM edges e1
//         JOIN edges e2
//             ON  e1.oprsNo     = e2.oprsNo
//             AND e2.from_seqNo >= e1.from_seqNo
//         JOIN best_arrival b
//           ON b.to_placeId = e2.to_placeId
//           AND b.arr_min = e2.arr_min
//         LEFT JOIN oprs_found ofnd
//             ON e2.oprsNO = ofnd.oprsNO
//           WHERE e1.from_placeId = ?
//             AND e1.dep_min BETWEEN ? AND ?
//             AND ofnd.oprsNo is NULL
//         ORDER BY dep_min
//       ''',
//         [
//           boardingStop, currarr + boardingBuffer, currarr + maxWaitMinutes, 
//           boardingStop, currarr + boardingBuffer, currarr + maxWaitMinutes
//         ],
//       );

//       for (final row in reachable) {
        
//         final String toPlaceId = row['to_placeId'];
//         final String oprsNo = row['oprsNo'];
//         final int dept = row['dep_min'];
//         final int arr = row['arr_min'];

//         final String stopKey = "$toPlaceId|$oprsNo";

//         if (!earliestArrival.containsKey(stopKey) ||
//             arr < earliestArrival[stopKey]!) {
//           earliestArrival[stopKey] = arr;
//           previous[stopKey] = stop;
//           stopTimes[stopKey] = Pair(dept, arr);
//           nextRoundStops.add(stopKey);
//         }
//       }
//     }
//     if(nextRoundStops.isEmpty) break;
//     currentRoundStops = nextRoundStops;
//   }

//   return await _buildResult(destinationPlaceId, previous, stopTimes);
// }

// Future<Result> _buildResult(
//   String destinationPlaceId, 
//   Map<String, String> previous, 
//   Map<String, Pair<int, int>> stopTimes
// ) async{
//   final List<String> destKeys = [];

//   final database = await DatabaseHelper().database;

//   // 1. Gather all keys that correspond to our destination
//   for (final key in stopTimes.keys) {
//     if (key.startsWith("$destinationPlaceId|")) {
//       destKeys.add(key);
//     }
//   }

//   // 2. If the destination was never reached, return an empty result
//   if (destKeys.isEmpty) return Result([], 0);

//   // 3. Find the key with the earliest arrival time
//   String bestKey = destKeys.first;
//   for (final key in destKeys) {
//     if (stopTimes[key]!.value < stopTimes[bestKey]!.value) {
//       bestKey = key;
//     }
//   }

//   // 4. Backtrack from destination to source
//   List<PathStop> path = [];
//   String? currentKey = bestKey;

//   while (currentKey != null && currentKey != "null") {
//     final times = stopTimes[currentKey];
//     final parts = currentKey.split('|');
    
//     if (times != null) {

//       final List<Map<String, dynamic>> row = await database.rawQuery(
//         '''
//           SELECT placeName from place_master where placeId = ?
//         ''',
//         [parts[0]],
//       );
//       // Insert at index 0 to build the path in chronological order
//       path.insert(0, PathStop(
//         placeId: parts[0],
//         arrivalTime: times.value,
//         placeName: row[0]['placeName'],
//         deptTime: times.key,
//         oprsNo: parts[1],
//       ));
//     }
    
//     // Move to the previous stop in the chain
//     currentKey = previous[currentKey];
//   }

//   // 5. Return the final constructed path and the best arrival time
//   return Result(path, stopTimes[bestKey]!.value);
// }

  



// class Pair<K, V> {
//   final K key;
//   final V value;

//   Pair(this.key, this.value);
// }

// class PathStop {
//   final String placeId;
//   final String placeName;
//   final int arrivalTime;
//   final int deptTime;

//   PathStop(this.placeId, this.arrivalTime, this.deptTime);
// }

// class Result {
//   List<PathStop> path;
//   int time;

//   Result(this.path, this.time);
// }

// Future<Result> marksAlgorithm(

//   // Input parameters
//   String sourcePlaceId,
//   String destinationPlaceId,
//   int startTime,

// ) async {

//   // EARLY EXIT: If either source or destination is not selected, return empty result immediately
//   if (sourcePlaceId.isEmpty || destinationPlaceId.isEmpty) return Result([], 0);

//   // Initialize database connection
//   final DatabaseHelper dbHelper = DatabaseHelper();
//   final database = await dbHelper.database;

//   print(
//     "Starting MARKS Algorithm from $sourcePlaceId to $destinationPlaceId at time $startTime",
//   );

//   /// best known arrival time at each stop
//   Map<String, int> earliestArrival = {};

//   /// previous stop of every stop in best path
//   Map<String, String?> previous = {};

//   /// arrival and departure times for the best path
//   Map<String, Pair<int, int>> stopTimes = {};

//   /// initialize source
//   earliestArrival[sourcePlaceId] = startTime;

//   Set<String> settled = {};

//   /// Priority Queue ordered by earliest known arrival time
//   PriorityQueue<String> queue = PriorityQueue<String>(
//     (a, b) => earliestArrival[a]!.compareTo(earliestArrival[b]!),
//   );

//   queue.add(sourcePlaceId);

//   // Increased max rounds because PQ doesn't waste time on useless wide searches
//   int maxRounds = 10; 
//   int currentRounds = 0;
//   int waitingTimeBuffer = 5;
//   int roundSize = queue.length;
//   int currsize = 0;

//   while (queue.isNotEmpty && currentRounds < maxRounds) {

//     if(currsize >= roundSize){
//       roundSize = queue.length;
//       currsize = 0;
//       currentRounds ++;
//     }

//     /// Get the node with the absolute earliest arrival time right now
//     String currentStop = queue.removeFirst();
//     currsize ++;

    

//     /// EARLY EXIT: Because we use a Priority Queue, popping the destination
//     /// guarantees we have found the absolute fastest route.
//     if (currentStop == destinationPlaceId) {
//       print(
//         " Destination $destinationPlaceId reached in $currentRounds rounds! Reconstructing path...",
//       );

//       List<PathStop> path = [];
//       String? curr = destinationPlaceId;

//       while (curr != null) {
//         if (curr == sourcePlaceId) {
//           path.insert(
//             0,
//             PathStop(curr, earliestArrival[curr]!, earliestArrival[curr]!),
//           );
//           break;
//         }

//         Pair<int, int> timing = stopTimes[curr]!;
//         path.insert(0, PathStop(curr, timing.key, timing.value));

//         curr = previous[curr];
//       }

//       return Result(path, earliestArrival[destinationPlaceId]!);
//     }

//     /// If we already fully explored the optimal paths from this node, skip it
//     if (settled.contains(currentStop)) {
//       continue;
//     }
    
//     settled.add(currentStop);

//     /// Arrival at current stop
//     int currentArrivalTime = earliestArrival[currentStop]!;
//     int maxWaitTime = currentArrivalTime + 240; // Looking 8 hours ahead max

    
//     /// Fetch future buses only
//     List<Map<String, dynamic>> edgesData = await database.rawQuery(
//       '''
//       SELECT *
//       FROM edges
//       WHERE from_placeId = ?
//       AND dep_min >= ?
//       AND dep_min <= ?
//       ORDER BY dep_min
      
//       ''',
//       [currentStop, currentArrivalTime + waitingTimeBuffer, maxWaitTime],
//     );

//     List<Map<String, dynamic>> isdestinationcheck = await database.rawQuery(
//       '''
//       SELECT *
//       FROM edges
//       WHERE from_placeId = ?
//       AND to_placeId = ?
//       AND dep_min >= ?
//       AND dep_min <= ?
//       ORDER BY dep_min
//       ''',
//       [currentStop, destinationPlaceId, currentArrivalTime + waitingTimeBuffer, maxWaitTime],
//     );

//     if(isdestinationcheck.isNotEmpty) {
//       print("Found direct edge to destination from $currentStop! Adding to queue.");
//       edgesData.insertAll(0, isdestinationcheck); // Prioritize direct edges to destination
//     }


//     if (edgesData.isEmpty) {
//       continue;
//     }

//     for (var edge in edgesData) {
//       final toPlaceId = edge['to_placeId'] as String?;
//       final deptTime = edge['dep_min'] as int?;
//       final arrTime = edge['arr_min'] as int?;

//       if (toPlaceId == null || deptTime == null || arrTime == null) {
//         print("BAD EDGE FOUND: $edge");
//         continue;
//       }

//       // If the destination node is already settled, no need to evaluate
//       if (settled.contains(toPlaceId)) continue;

//       int adjustedArrTime = arrTime;

//       // Handle midnight wrap-around
//       if (adjustedArrTime < deptTime) {
//         adjustedArrTime += 1440;
//       }

//       // Invalid timing check
//       if (adjustedArrTime < deptTime) {
//         continue;
//       }

//       /// Earliest arrival pruning
//       bool isBetter =
//           !earliestArrival.containsKey(toPlaceId) ||
//           adjustedArrTime < earliestArrival[toPlaceId]!;

//       if (isBetter) {
//         /// update best arrival
//         earliestArrival[toPlaceId] = adjustedArrTime;
//         previous[toPlaceId] = currentStop;
//         stopTimes[toPlaceId] = Pair(adjustedArrTime, deptTime);

//         /// Add to Priority Queue so it gets sorted automatically
//         queue.add(toPlaceId);
//       }
//     }
//   }

//   /// no route found or max rounds exceeded
//   print("❌ No route found or max rounds exceeded.");
//   return Result([], 0);
// }














// List<Map<String, double>> marksAlgorithm(
//   Map<String, List<Edge>> graph,
//   List<String> sourcenodes,
//   List<String> destinationnodes,
// ) {
//   Map<String, double> distances = {};
//   Map<String, String?> previous = {};

//   for (var node in graph.keys) {
//     distances[node] = double.infinity;
//     previous[node] = null;
//   }

//   // MULTIPLE SOURCES
//   for (var source in sourcenodes) {
//     distances[source] = 0;
//   }

//   var destinationSet = destinationnodes.toSet();

//   var pq = PriorityQueue<String>(
//     (a, b) => distances[a]!.compareTo(distances[b]!),
//   );

//   for (var source in sourcenodes) {
//     pq.add(source);
//   }

//   String? foundDestination;
//   int stepCount = 0;

//   while (pq.isNotEmpty) {
//     String currentNode = pq.removeFirst();

//     if (stepCount < 10) {
//       print(
//         "Visiting node: $currentNode, current distance: ${distances[currentNode]}",
//       );
//     }
//     stepCount++;

//     // STOP WHEN ANY DESTINATION REACHED
//     if (destinationSet.contains(currentNode)) {
//       foundDestination = currentNode;
//       print(
//         "Reached destination node: $currentNode with distance ${distances[currentNode]}",
//       );
//       break;
//     }

//     for (var edge in graph[currentNode] ?? []) {
//       double newDistance = distances[currentNode]! + edge.distance;

//       //SAFE CHECK
//       if (newDistance < (distances[edge.toplaceId] ?? double.infinity)) {
//         distances[edge.toplaceId] = newDistance;
//         previous[edge.toplaceId] = currentNode;
//         pq.add(edge.toplaceId);

//         if (stepCount < 10) {
//           print(
//             "Updated distance: ${edge.toplaceId} = $newDistance, prev=$currentNode",
//           );
//         }
//       }
//     }
//   }

//   // IF NO PATH
//   if (foundDestination == null) {
//     print("No path found to any destination node.");
//     return [];
//   }

//   String destination = foundDestination;
//   print(
//     "Shortest distance to destination $destination: ${distances[destination]}",
//   );

//   //BUILD PATH
//   List<Map<String, double>> path = [];
//   String? curr = foundDestination;
//   String? lastOprs;

//   int pathPrintLimit = 0;

//   while (curr != null && previous[curr] != null) {
//     String placeName = curr;
//     String? prevNode = previous[curr];
    

//     String currOprs = curr.split("|")[1];

//     double Distance = 0;

//     if (prevNode != null) {
//       for (var edge in graph[prevNode] ?? []) {
//         if (edge.toplaceId == curr) {
//           //USE EDGE NAME
//           placeName = edge.toPlaceName ?? curr;
//           Distance = distances[curr] ?? 0;
//           break;
//         }
//       }
//     }

//     if (lastOprs == null || currOprs != lastOprs) {
//       path.insert(0, {placeName: Distance});

//       if (pathPrintLimit < 5) {
//         print("Path step: $placeName -> $Distance km");
//         pathPrintLimit++;
//       }
//     }

//     lastOprs = currOprs;
//     curr = prevNode;
//   }

//   print("Final path (first 5 steps if long): ${path.take(5).toList()}");

//   return path;
// }

