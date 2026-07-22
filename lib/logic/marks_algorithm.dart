import 'dart:math';


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
  final double? distance;
  final int? time;
  final String? serviceType;
  final String? vehicleNo;
  Map<String, String>? stopDetails;

  PathStop({
    required this.placeId,
    required this.placeName,
    required this.arrivalTime,
    required this.deptTime,
    required this.oprsNo,
    this.time,
    this.distance,
    this.serviceType,
    this.vehicleNo,
    this.stopDetails
    
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

    if(destinationFoundState > 1) break;

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
      params.add(currArr + (round != 1 ? boardingBuffer : 0));
      params.add(currArr + maxWaitMinutes);

      for(int i = 0; i < usedList.length; i++){
        params.add(usedList[i]);
      }

      List<Map<String, dynamic>> reachable =
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

      if(currArr + maxWaitMinutes >= 1440){

       params[0] = boardingStop;
       params[1] = max(0, currArr - 1440) + boardingBuffer;
       params[2] = min(currArr - 1440 + maxWaitMinutes, 390);

        final  List<Map<String, dynamic>> midNightReachable =
          await database.rawQuery('''
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

       reachable = [
        ...reachable,
        ...midNightReachable
       ];
      }

      
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
      destinationFoundState++;
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
      time: times.value - times.key

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
      oprsNo:      rawPath[i + 1].oprsNo,
      time : rawPath[i].time
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
  List<String> oprsNo = [];
  for (var p in rawPath) {
    if (!placeIds.contains(p.placeId)) {
      placeIds.add(p.placeId);
      oprsNo.add(p.oprsNo);
    }
  }

  Map<String, String> nameLookup = {};
  Map<String, String> serviceTypeLookup = {};
  Map<String, String> vehicleNoLookup = {};
  Map<String, Map<String, String>>stopDetailsLookup = {};
  // Map<String, double> latLookup = {};
  // Map<String, double> lonLookup = {};

  if (placeIds.isNotEmpty) {
    String placeholders = "";

    for (int i = 0; i < placeIds.length; i++) {
      placeholders += "?";
      if (i != placeIds.length - 1) {
        placeholders += ",";
      }
    }
    final List<Map<String, dynamic>> rows = await database.rawQuery(
      'SELECT * FROM place_master WHERE placeId IN ($placeholders)',
      placeIds,
    );

    

    

    for (final row in rows) {

      final id = row['placeId'].toString();

      nameLookup[id] = row['placeName']?.toString() ?? 'Unknown';

      stopDetailsLookup[id] = {
        "placeId" : row['placeId'].toString(),
        "placeName" :  row['placeName']?.toString() ?? 'Unknown',
        "pincode" : row['pincode'].toString(),
        "address" : row['address'].toString(),
        'latitude' : row['latitude'].toString(),
        'longitude' : row['longitude'].toString(),
        'district' : row['district'].toString(),
      };

      // latLookup[id] = (row['latitude'] as num?)?.toDouble() ?? 0.0;
      // lonLookup[id] = (row['longitude'] as num?)?.toDouble() ?? 0.0;
    }
  }

  
    
   if (oprsNo.isNotEmpty) {
  final placeholders = List.filled(oprsNo.length, '?').join(',');

  final List<Map<String, dynamic>> serviceDetails =
      await database.rawQuery(
    '''
    SELECT oprsNo, vehicleNumber, serviceType
    FROM service_details
    WHERE oprsNo IN ($placeholders)
    ''',
    oprsNo,
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
    

     time = (rawPath[i].deptTime) -  (rawPath[i + 1].arrivalTime);

     int arrival = rawPath[i+ 1].arrivalTime;
      int dept = rawPath[i].deptTime;

     

    

    if(arrival < dept)
    {
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

  print("Path: ${path.length} stop(s) | arrival=${stopTimes[bestKey]!.value}");

  
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

  return Result(path, stopTimes[bestKey]!.value);
}



