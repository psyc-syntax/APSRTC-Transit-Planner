import "dart:io";
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
import 'package:flutter/services.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "apsrtc_master.db");

    print("DB PATH: $path");

    // 🔥 IMPORTANT: always copy fresh DB (for debugging)
    if (await File(path).exists()) {
      await deleteDatabase(path);
      print("OLD DB DELETED");
    }

    print("COPYING DB FROM ASSETS...");

    ByteData data =
        await rootBundle.load("assets/data/apsrtc_master.db");

    List<int> bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    await File(path).writeAsBytes(bytes, flush: true);

    print("DB COPIED SUCCESSFULLY");

    return await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getsearchstops(String query) async {
  final db = await database;

  if (query.isEmpty) {
    return await db.rawQuery(
        "SELECT placeName, district, pincode, address FROM Place_Master ORDER BY placeName");
  }

  return await db.rawQuery(
    "SELECT placeName, district, pincode, address FROM Place_Master WHERE LOWER(placeName) LIKE ? ORDER BY placeName",
    ['${query.toLowerCase()}%'],
  );
}
}