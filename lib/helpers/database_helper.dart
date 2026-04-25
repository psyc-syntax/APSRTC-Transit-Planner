import "dart:io";
import "package:flutter/services.dart";
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "package:planner_demo/logic/distance_calculator_by_lat_and_lon.dart";
import "package:planner_demo/models/bus_trip.dart";
import "package:planner_demo/models/edge.dart";

class DatabaseHelper {
  static Database? _database;

  List<BusTrip>? _cachedTrips;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "apsrtc_master.sqli");

    if (!await File(path).exists()) {
      ByteData data = await rootBundle.load("assets/data/apsrtc_master.sqli");

      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getsearchstops(String query) async {
    final db = await database;

    if (query.isEmpty) {
      return await db.rawQuery(
        "SELECT placeName, district, pincode, address, placeId FROM Place_Master ORDER BY placeName LIMIT 100",
      );
    }

    return await db.rawQuery(
      "SELECT placeName, district, pincode, address, placeId FROM Place_Master WHERE LOWER(placeName) LIKE ? ORDER BY placeName LIMIT 100",
      ['${query.toLowerCase()}%'],
    );
  }

  Future<List<BusTrip>> getBusTrips() async {
    if (_cachedTrips != null) return _cachedTrips!;

    final db = await database;

    List<Map<String, dynamic>> results = await db.rawQuery("""
      SELECT serviceDocId, oprsNo, placeId, seqNo, placeName, 
             stationName, latitude, longitude, 
             scheduleArrTime, scheduleDepTime 
      FROM route_stops 
      ORDER BY OPRSNo, SeqNo
    """);

    _cachedTrips = results.map((row) {
      return BusTrip(
        serviceDocId: row['serviceDocId'] ?? "",
        oprsNo: row['oprsNo']?.toString() ?? "",
        placeId: row['placeId']?.toString() ?? "",
        seqNo: row['seqNo'] ?? 0,
        placeName: row['placeName'] ?? "",
        stationName: row['stationName'] ?? "",
        latitude: (row['latitude'] as num?)?.toDouble() ?? 0.0,
        longitude: (row['longitude'] as num?)?.toDouble() ?? 0.0,
        scheduleArrTime: row['scheduleArrTime'] ?? "",
        scheduleDepTime: row['scheduleDepTime'] ?? "",
      );
    }).toList();

    return _cachedTrips!;
  }

  Map<String, List<String>> buildStopIndex(
    Map<String, List<BusTrip>> groupedTrips,
  ) {
    Map<String, List<String>> stopIndex = {};

    for (var trip in groupedTrips.values) {
      for (var busTrip in trip) {
        String node = "${busTrip.placeId}|${busTrip.oprsNo}";

        stopIndex.putIfAbsent(busTrip.placeId, () => []);

        if (!stopIndex[busTrip.placeId]!.contains(node)) {
          stopIndex[busTrip.placeId]!.add(node);
        }
      }
    }

    return stopIndex;
  }

  // Map<String, String> buildIdToNameMap(List<BusTrip> trips) {
  //   Map<String, String> map = {};
  //   for (var t in trips) {
  //     map[t.placeId] = t.placeName;
  //   }
  //   return map;
  // }

  Map<String, List<BusTrip>> groupBusTripsByOprsNo(List<BusTrip> trips) {
    final map = <String, List<BusTrip>>{};

    for (var t in trips) {
      if (t.oprsNo.isNotEmpty) {
        map.putIfAbsent(t.oprsNo, () => []).add(t);
      }
    }

    return map;
  }

  void sortTripsBySeqNo(Map<String, List<BusTrip>> grouped) {
    for (var list in grouped.values) {
      list.sort((a, b) => a.seqNo.compareTo(b.seqNo));
    }
  }

  Map<String, List<Edge>> buildGraph(
    Map<String, List<BusTrip>> groupedTrips,
  ) {
    Map<String, List<Edge>> graph = {};

    for (var trip in groupedTrips.values) {
      for (int i = 0; i < trip.length - 1; i++) {
        var from = trip[i];
        var to = trip[i + 1];

        final fromNode = "${from.placeId}|${from.oprsNo}";
        final toNode = "${to.placeId}|${to.oprsNo}";

        double distance = calculateDistance(
          from.latitude,
          from.longitude,
          to.latitude,
          to.longitude,
        );

        graph.putIfAbsent(fromNode, () => []);
        graph.putIfAbsent(toNode, () => []);

        graph[fromNode]!.add(
          Edge(
            fromplaceId: fromNode,
            toplaceId: toNode,
            fromPlaceName: from.placeName,
            toPlaceName: to.placeName,
            distance: distance,
            travelTime: 120,
          ),
        );
      }
    }

    return graph;
  }
}

void addTransferEdges(
  Map<String, List<Edge>> graph,
  Map<String, List<String>> stopIndex,
) {
  for (var placeId in stopIndex.keys) {
    var nodes = stopIndex[placeId]!;

    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        String fromNode = nodes[i];
        String toNode = nodes[j];

        graph.putIfAbsent(fromNode, () => []);
        graph.putIfAbsent(toNode, () => []);

        graph[fromNode]!.add(
          Edge(
            fromplaceId: fromNode,
            toplaceId: toNode,
            fromPlaceName: placeId,
            toPlaceName: placeId,
            distance: 2,
            travelTime: 300,
          ),
        );

        graph[toNode]!.add(
          Edge(
            fromplaceId: toNode,
            toplaceId: fromNode,
            fromPlaceName: placeId,
            toPlaceName: placeId,
            distance: 2,
            travelTime: 300,
          ),
        );
      }
    }
  }
}