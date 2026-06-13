
import 'package:collection/collection.dart';

import 'package:planner_demo/helpers/database_helper.dart';

// =========================================================
//
//   MARKS ALGORITHM — ROUND-BASED (RAPTOR-style)
//   MARK — Transit Intelligence
//
// =========================================================
//
//  HOW ROUNDS WORK
//
//  Each round = one bus taken (one additional transfer).
//  Within a round, you can travel the ENTIRE length
//  of a route — not just one stop at a time.
//
//  Round 1:  Board any bus from source.
//            Scan ALL stops on that route forward.
//            Source reaches 20+ stops in round 1.
//
//  Round 2:  At any stop reached in round 1,
//            board a DIFFERENT bus. Scan its stops.
//            1 transfer covered.
//
//  Round 3, 4, 5: each = one more transfer.
//
//  5 rounds = 4 transfers. Covers any AP/Telangana journey.
//
//  KEY QUERY (does all the heavy lifting):
//
//    SELECT e2.to_placeId, MIN(e2.arr_min)
//    FROM edges e1
//    JOIN edges e2
//        ON  e1.oprsNo = e2.oprsNo        -- same bus
//        AND e2.from_seqNo >= e1.from_seqNo -- forward only
//    WHERE e1.from_placeId = ?            -- boarding stop
//      AND e1.dep_min BETWEEN ? AND ?     -- departs after arrival
//    GROUP BY e2.to_placeId
//
//  One call per stop per round. Scans entire routes.
//
// =========================================================


class Pair<K, V> {
  final K key;
  final V value;
  Pair(this.key, this.value);
}

class PathStop {
  final String placeId;
  final String placeName; // Optional: can be fetched from DB if needed
  final int    arrivalTime;
  final int    deptTime;
  final String oprsNo; // Added to track the bus route taken at this stop


  PathStop(this.placeId, this.placeName, this.arrivalTime, this.deptTime, this.oprsNo);
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

  // ── State ──────────────────────────────────────────────
  final Map<String, int>            earliestArrival = {sourcePlaceId: startTime};
  final Map<String, String>         previous        = {};
  final Map<String, Pair<int, int>> stopTimes       = {};
  final Map<String, String>        oprsAtStop      = {};

  // Stops improved in the last round.
  // Round 1 starts from source.

  Map<String, int> markedLastRound = {sourcePlaceId: startTime};

  // ── Config ─────────────────────────────────────────────
  const int maxRounds      = 6;    // 5–6 covers any AP/Telangana journey
  const int maxWaitMinutes = 240;  // max 4 hours wait for a connecting bus
  const int boardingBuffer = 5;    // 5 min minimum boarding time

  // =========================================================
  // MAIN LOOP
  // Each iteration = one round = one bus taken
  // =========================================================

  for (int round = 1; round <= maxRounds; round++) {

    if (markedLastRound.isEmpty) break;

    print("Round $round | boarding from ${markedLastRound.length} stop(s)");

    final Map<String, int> improvedThisRound = {};

    for (final entry in markedLastRound.entries) {

      final String boardingStop  = entry.key;
      final int    arrivalHere   = entry.value;
      final int    earliestBoard = arrivalHere + boardingBuffer;
      final int    latestBoard   = arrivalHere + maxWaitMinutes;

      // ── ROUTE SCAN QUERY ───────────────────────────────
      //
      // e1 = boarding edge at boardingStop
      // e2 = any subsequent edge on the SAME route (same oprsNo)
      //
      // Returns every stop this bus reaches,
      // with the earliest arrival time at each.
      //
      // This is what makes 5-6 rounds sufficient:
      // one query scans an entire 20-stop route,
      // not just the next single hop.
      //
      // ──────────────────────────────────────────────────

      final List<Map<String, dynamic>> reachable =
          await database.rawQuery('''
        SELECT
            e2.to_placeId        AS to_placeId,
            e2.from_placeId      AS from_placeId,
            e2.oprsNo            AS oprsNo,
            e2.dep_min           AS dep_min,
            MIN(e2.arr_min)      AS arr_min
        FROM edges e1
        JOIN edges e2
            ON  e1.oprsNo     = e2.oprsNo
            AND e2.from_seqNo >= e1.from_seqNo
        WHERE e1.from_placeId = ?
          AND e1.dep_min BETWEEN ? AND ?
        GROUP BY e2.to_placeId
        ORDER BY arr_min ASC
      ''', [boardingStop, earliestBoard, latestBoard]);

      for (final row in reachable) {

        final String? toId   = row['to_placeId']   as String?;
        final String? fromId = row['from_placeId'] as String?;
        final String? oprsNo = row['oprsNo']       as String?;
        final int?    dep    = row['dep_min']       as int?;
        final int?    arr    = row['arr_min']       as int?;

        if (toId == null || dep == null || arr == null) continue;

        final bool isBetter = !earliestArrival.containsKey(toId) ||
                               arr < earliestArrival[toId]!;

        if (isBetter) {
          earliestArrival[toId]    = arr;
          previous[toId]           = fromId ?? boardingStop;
          stopTimes[toId]          = Pair(arr, dep);
          oprsAtStop[toId]         = oprsNo ?? '';
          improvedThisRound[toId]  = arr;
        }
      }
    }

    print(
      "  Round $round: ${improvedThisRound.length} stops improved"
      " | dest=${earliestArrival[destinationPlaceId] ?? 'not yet'}",
    );

    // ── Destination found — stop after this full round ──
    // Finishing the round guarantees best time within
    // this transfer count (not just first-found).
    if (earliestArrival.containsKey(destinationPlaceId)) {
      print("  ✅ Destination found in round $round");
      break;
    }

    markedLastRound = improvedThisRound;
  }

  // =========================================================
  // NO ROUTE FOUND
  // =========================================================

  if (!earliestArrival.containsKey(destinationPlaceId)) {
    print("❌ No route found in $maxRounds rounds.");
    return Result([], 0);
  }

  // =========================================================
  // RECONSTRUCT PATH
  // Walk backwards from destination to source
  // =========================================================

  final List<PathStop> path = [];
  String? curr = destinationPlaceId;
  String? lastOprs = null;

  while (curr != null) {

    final List<Map<String, dynamic>> stopInfo = await database.rawQuery(
        'SELECT placeName FROM place_master WHERE placeId = ?',
        [curr],
      );

    final String safePlaceName = stopInfo.isNotEmpty 
        ? stopInfo.first['placeName'] as String 
        : 'Unknown Stop';

    if (curr == sourcePlaceId) {
      path.insert(0, PathStop(curr, safePlaceName, startTime, startTime, oprsAtStop[curr] ?? ''));
      break;
    }


    final timing = stopTimes[curr];


    if (timing == null) break;


    final oprsNo = oprsAtStop[curr];

    // If it's a new bus route OR we are at the destination (lastOprs == null), add it.
    if (lastOprs == null || oprsNo != lastOprs) {
      
      path.insert(0, PathStop(curr, safePlaceName, timing.key, timing.value, oprsNo ?? ''));
      lastOprs = oprsNo; // Track the route we are currently walking backward on
    }
    curr = previous[curr];
  }

  print("Done: ${path.length} stops | arrival=${earliestArrival[destinationPlaceId]}");
  return Result(path, earliestArrival[destinationPlaceId]!);
}


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

