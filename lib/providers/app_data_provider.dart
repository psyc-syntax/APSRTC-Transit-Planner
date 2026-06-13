import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:planner_demo/models/app_data.dart';

final appdataProvider = FutureProvider<AppData>((ref) async {
  final dbhelper = DatabaseHelper();

  final database = await dbhelper.database;

  return AppData(
    database: database,
  );
});