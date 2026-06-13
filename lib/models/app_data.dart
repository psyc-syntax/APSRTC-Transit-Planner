
import 'package:sqflite/sqlite_api.dart';

class AppData {
  final Database database;


  AppData({
    required this.database,
  });

  void operator [](String other) {}
}