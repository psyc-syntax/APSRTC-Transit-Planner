import "dart:io";
import "package:planner_demo/models/bus_trip.dart";
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
import 'package:flutter/services.dart';

class DatabaseHelper {
  static Database? _database;

//geting database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }
//initializing database if it is not present in device
  Future<Database> initDb() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "apsrtc_master.sqli");

    print("DB PATH: $path");

    //IMPORTANT: always copy fresh DB (for debugging)
    if (await File(path).exists()) {
      await deleteDatabase(path);
      print("OLD DB DELETED");
    }

    print("COPYING DB FROM ASSETS...");

    ByteData data = await rootBundle.load("assets/data/apsrtc_master.sqli");

    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    await File(path).writeAsBytes(bytes, flush: true);

    print("DB COPIED SUCCESSFULLY");

    return await openDatabase(path);
  }

//fetching search results for stops based on user query
  Future<List<Map<String, dynamic>>> getsearchstops(String query) async {
    final db = await database;

    if (query.isEmpty) {
      return await db.rawQuery(
        "SELECT placeName, district, pincode, address, placeId FROM Place_Master ORDER BY placeName",
      );
    }

    return await db.rawQuery(
      "SELECT placeName, district, pincode, address, placeId FROM Place_Master WHERE LOWER(placeName) LIKE ? ORDER BY placeName",
      ['${query.toLowerCase()}%'],
    );
  }


//fetching bus trips and creating each object for each trip
  Future<List<BusTrip>> getBusTrips() async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT serviceDocId, oprsNo, placeId, seqNo, placeName, stationName, latitude, longitude, scheduleArrTime, scheduleDepTime FROM Bus_Trip ORDER BY OPRSNo, SeqNo",
    );

    return results.map((row) => BusTrip(
      serviceDocId: row['serviceDocId'],
      oprsNo: row['oprsNo'],
      placeId: row['placeId'],
      seqNo: row['seqNo'],
      placeName: row['placeName'],
      stationName: row['stationName'],
      latitude: row['latitude'],
      longitude: row['longitude'],
      scheduleArrTime: row['scheduleArrTime'],
      scheduleDepTime: row['scheduleDepTime'],
    )).toList();
  }

  //
}
