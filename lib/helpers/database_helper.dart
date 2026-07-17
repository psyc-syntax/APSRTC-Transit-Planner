import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:planner_demo/logic/jsont_converters.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/logic/trip_id_generator.dart';


import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class DatabaseHelper {
  //database initialization
  static Database? _database;

  //method to get database
  Future<Database> get database async {
  if (_database != null) {
    return _database!;
  } else {
    _database = await intDatabase();
    return _database!;
  }
}

  //method to initialize database
  Future<Database> intDatabase() async {
    //get path of the apps database
    String dbPath = await getDatabasesPath();

    //adding the our database to app database
    String path = join(dbPath, "apsrtc_v1.db");

    //if our database doesnt exist in the apps database then adding it to the database from the assets folder
    if (!await File(path).exists()) {
      //getting byte format of data from the database
      ByteData data = await rootBundle.load("assets/data/apsrtc_v1.db");

      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(path).writeAsBytes(bytes);
    }

    //returning the database
    return await openDatabase(path);
  }

  //method to get stop details from the database based on query
  Future<List<Map<String, dynamic>>> getSearchStops(String query) async {
  final db = await database;
  final cleanQuery = query.trim();

  // 1. If query is empty, return top 100 stops that have at least some metadata
  if (cleanQuery.isEmpty) {
    return await db.rawQuery('''
      SELECT placeName, district, pincode, address, placeId ,latitude, longitude
      FROM place_master 
      WHERE placeId IS NOT NULL
        AND (pincode IS NOT NULL OR address IS NOT NULL OR district IS NOT NULL)
      ORDER BY placeName 
      LIMIT 100
    ''');
  } 
  
  // 2. Search query matches name AND has at least some metadata
  else {
    return await db.rawQuery('''
      SELECT placeName, district, pincode, address, placeId, latitude, longitude
      FROM place_master 
      WHERE placeName LIKE ? 
        AND (pincode IS NOT NULL OR address IS NOT NULL OR district IS NOT NULL)
      ORDER BY placeName 
      LIMIT 100
    ''', ['$cleanQuery%']);
  }

}


//save trip helper
Future<void> saveTrip(Result result) async{
  final db = await database;

  final id = generateTripId(result);

  await db.insert("saved_trips",
    {
      "tripId" : id,
      "trip_json" : jsonEncode(resultToJson(result, id)),
    },
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );
  
}


//delete saved trip block
Future<void> deleteTrip(Result result)
async{
  final db = await database;
  final id = generateTripId(result);

  await db.delete(
    "saved_trips",
    where: "tripId=?",
    whereArgs: [id]
  );

}


//finding does trip is saved
Future<bool> isTripSaved(Result result) async {
  final db = await database;

  final id = generateTripId(result);

  final rows = await db.query(
    "saved_trips",
    where: "tripId=?",
    whereArgs: [id]
  );

  return rows.isNotEmpty;
}


//to get list of saved trips
Future<List<Result>> getSavedTrips()async{
  final db = await database;

  final rows = await db.query(
    "saved_trips",
    orderBy: "saved_time DESC"
  );

  List<Result> savedTrips = [];

  for(final row in rows){
    final json = jsonDecode(row["trip_json"] as String);

    savedTrips.add(
      resultFromJson(json)
    );
  }

  return savedTrips;
}


//   //building stop index like  a = [a|100, a|200, b|300]
//   Map<String, List<String>> buildStopIndex(Map<String, List<BusTrip>> grouped) {
//     final Map<String, List<String>> stopIndex = {};

//     for (var trip in grouped.values) {
//       for (var bustTrip in trip) {
//         String Node = "${bustTrip.placeId}|${bustTrip.oprsNo}";
//         stopIndex.putIfAbsent(bustTrip.placeId, () => []);
//         stopIndex[bustTrip.placeId]!.add(Node);
//       }
//     }
//     return stopIndex;
//   }

//   Future<GraphData> buildGraphAndStopIndex() async {
//   final db = await database;

//   Map<String, List<Edge>> graph = {};
//   Map<String, List<String>> stopIndex = {};

//   List<Map<String, dynamic>> rows = await db.rawQuery("""
//     SELECT oprsNo, placeId, placeName, seqNo,
//            latitude, longitude, 
//            arr_time_min, dept_time_min 
//     FROM route_stops 
//     WHERE oprsNo IS NOT NULL
//     ORDER BY oprsNo, seqNo
//   """);

//   for (int i = 0; i < rows.length; i++) {
//     var current = rows[i];

//     String oprsNo = current["oprsNo"]?.toString() ?? "";
//     String placeId = current["placeId"]?.toString() ?? "";
//     String placeName = current["placeName"]?.toString() ?? "";
//     int deptTimeMin = current["dept_time_min"] ?? 0;

//     if (oprsNo.isEmpty || placeId.isEmpty) continue;

//     String node = "$placeId|$oprsNo";

//     // STOP INDEX
//     stopIndex.putIfAbsent(placeId, () => []);
//     stopIndex[placeId]!.add(node);

//     // GRAPH NODE
//     graph.putIfAbsent(node, () => []);

//     // SAME ROUTE CONNECTION
//     if (i < rows.length - 1) {
//       var next = rows[i + 1];

//       if (current["oprsNo"] == next["oprsNo"]) {
//         String nextPlaceId = next["placeId"]?.toString() ?? "";
//         String nextNode = "$nextPlaceId|$oprsNo";
//         String nextPlaceName = next["placeName"]?.toString() ?? "";
//         int arrTimeMin = next['arr_time_min'] ?? 0;


//         double lat1 = (current["latitude"] as num?)?.toDouble() ?? 0.0;
//         double lon1 = (current["longitude"] as num?)?.toDouble() ?? 0.0;

//         double lat2 = (next["latitude"] as num?)?.toDouble() ?? 0.0;
//         double lon2 = (next["longitude"] as num?)?.toDouble() ?? 0.0;

//         double distance = calculateDistance(lat1, lon1, lat2, lon2);

//         int time =
//             (next["arr_time_min"] ?? 0) - (current["dept_time_min"] ?? 0);

//         if (time < 0) time += 1440;

//         graph[node]!.add(
//           Edge(
//             fromplaceId: node,
//             toplaceId: nextNode,
//             fromPlaceName: placeName,
//             toPlaceName: nextPlaceName,
//             arrTimeMin: arrTimeMin,
//             deptTimeMin: deptTimeMin,
//             distance: distance.roundToDouble(),
//             travelTime: time,
//           ),
//         );
//       }
//     }
//   }

//   // TRANSFER EDGES
//   for (var entry in stopIndex.entries) {
//     List<String> nodes = entry.value;

//     if (nodes.length > 1) {
//       for (var from in nodes) {
//         for (var to in nodes) {
//           if (from != to) {
//             graph[from]!.add(
//               Edge(
//                 fromplaceId: from,
//                 toplaceId: to,
//                 toPlaceName: "",
//                 fromPlaceName: "",
//                 arrTimeMin: 0,
//                 deptTimeMin: 0,
//                 distance: 0,
//                 travelTime: 300, // 5 min transfer
//               ),
//             );
//           }
//         }
//       }
//     }
//   }

//   print("Graph nodes: ${graph.length}");
//   print("Stops indexed: ${stopIndex.length}");

//   return GraphData(graph: graph, stopIndex: stopIndex);
// }
}
