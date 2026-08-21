import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:planner_demo/logic/jsont_converters.dart';

import 'package:planner_demo/logic/trip_id_generator.dart';


import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

import '../models/app_data.dart';

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

  
  // Method to get the absolute file path for the background Isolate
  Future<String> getDatabaseFilePath() async {
    // Await the database getter first. 
    // This guarantees the DB is copied from assets if it's the first time running.
    await database; 
    
    String dbPath = await getDatabasesPath();
    return join(dbPath, "ap_v2.db");
  }

  

  //method to initialize database
  Future<Database> intDatabase() async {
    //get path of the apps database
    String dbPath = await getDatabasesPath();

    //adding the our database to app database
    String path = join(dbPath, "ap_v2.db");

    //if our database doesnt exist in the apps database then adding it to the database from the assets folder
    if (!await File(path).exists()) {
      //getting byte format of data from the database
      ByteData data = await rootBundle.load("assets/data/ap_v2.db");

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
      
    ''');
  } 
  
  // 2. Search query matches name AND has at least some metadata

    final searchResults =  await db.rawQuery('''
      SELECT placeName, district, pincode, address, placeId, latitude, longitude
      FROM place_master 
      WHERE placeName LIKE ? 
        AND (pincode IS NOT NULL OR address IS NOT NULL OR district IS NOT NULL)
      ORDER BY placeName 
      
    ''', ['$cleanQuery%']);

    if(searchResults.isEmpty){
      return await db.rawQuery('''
      SELECT placeName, district, pincode, address, placeId, latitude, longitude
      FROM place_master
      WHERE placeName LIKE ?
      ORDER BY placeName
      
    ''', ['$cleanQuery%']);
    }

  return searchResults;


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

}
