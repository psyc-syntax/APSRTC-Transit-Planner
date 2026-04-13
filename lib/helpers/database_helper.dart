import "dart:io";
import "package:planner_demo/logic/distance_calculator_by_lat_and_lon.dart";
import "package:planner_demo/models/bus_trip.dart";
import "package:planner_demo/models/edge.dart";
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
import 'package:flutter/services.dart';

class DatabaseHelper {
  static Database? _database;

  // CACHE
  List<BusTrip>? _cachedTrips;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  // DB INIT
  Future<Database> initDb() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "apsrtc_master.sqli");

    // Only copy DB if it doesn't exist
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

  // SEARCH STOPS
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

  // FETCH TRIPS (WITH CACHE + LIMIT)
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

    _cachedTrips = results
        .map(
          (row) => BusTrip(
            serviceDocId: row['serviceDocId'] ?? "",
            oprsNo: row['oprsNo']?.toString() ?? "",
            placeId: row['placeId']?.toString() ?? "", // <-- keep as string unique ID
            seqNo: row['seqNo'] ?? 0,
            placeName: row['placeName'] ?? "",
            stationName: row['stationName'] ?? "",
            latitude: (row['latitude'] as num?)?.toDouble() ?? 0.0,
            longitude: (row['longitude'] as num?)?.toDouble() ?? 0.0,
            scheduleArrTime: row['scheduleArrTime']?? "",
            scheduleDepTime: row['scheduleDepTime'] ?? "",
          ),
        )
        .toList();

    return _cachedTrips!;
  }

  Map<String, List<String>> buildStopIndex(
    Map<String, List<BusTrip>> groupedTrips,
  ) {
    Map<String, List<String>> stopIndex = {};

    for (var trip in groupedTrips.values) {
      for (var busTrip in trip) {
        // create unique node
        String node = "${busTrip.placeId}|${busTrip.oprsNo}";

        // map placeId → list of nodes
        stopIndex.putIfAbsent(busTrip.placeId, () => []);

        // avoid duplicates (important)
        if (!stopIndex[busTrip.placeId]!.contains(node)) {
          stopIndex[busTrip.placeId]!.add(node);
        }
      }
    }

    print("StopIndex built: ${stopIndex.length} stops");
    return stopIndex;
  }

  // ID -> NAME MAP
  Map<String, String> buildIdToNameMap(List<BusTrip> trips) {
    Map<String, String> idToName = {};
    for (var trip in trips) {
      idToName[trip.placeId] = trip.placeName; // placeId is unique key
    }
    return idToName;
  }

  // GROUP BY OPRS
  Map<String, List<BusTrip>> groupBusTripsByOprsNo(List<BusTrip> busTrips) {
    final Map<String, List<BusTrip>> groupedTrips = {};

    for (var trip in busTrips) {
      if (trip.oprsNo.isNotEmpty) {
        groupedTrips.putIfAbsent(trip.oprsNo, () => []).add(trip);
      }
    }

    return groupedTrips;
  }

  // SORT BY SEQUENCE
  void sortTripsBySeqNo(Map<String, List<BusTrip>> groupedTrips) {
    for (var trip in groupedTrips.values) {
      trip.sort((a, b) => a.seqNo.compareTo(b.seqNo));
    }
  }

  // BUILD GRAPH
  Map<String, List<Edge>> buildGraph(Map<String, List<BusTrip>> groupedTrips) {
    Map<String, List<Edge>> graph = {};

    for (var trip in groupedTrips.values) {
      for (int i = 0; i < trip.length - 1; i++) {
        var from = trip[i];
        var to = trip[i + 1];

        final fromNode =
            "${from.placeId}|${from.oprsNo}"; // <-- now placeId only
        final toNode = "${to.placeId}|${to.oprsNo}"; // <-- now placeId only

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

    print("Graph built: ${graph.keys.length} nodes (show 5 nodes)");
    int count = 0;
    graph.forEach((k, v) {
      if (count++ < 5) {
        print(
          "$k -> ${v.take(3).map((e) => "${e.toplaceId}:${e.distance}").toList()}",
        );
      }
    });

    return graph;
  }
}

void addTransferEdges(Map<String, List<Edge>> graph, Map<String, List<String>> stopIndex) {
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
            distance: 2, // very small distance for transfer
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