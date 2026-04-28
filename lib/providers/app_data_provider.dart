import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:planner_demo/models/app_data.dart';

final appdataProvider = FutureProvider<AppData>((ref) async {
  final dbhelper = DatabaseHelper();

  final graphData = await dbhelper.buildGraphAndStopIndex();

  return AppData(
    graph: graphData.graph,
    stopIndex: graphData.stopIndex,
  );
});