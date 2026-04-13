import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:planner_demo/models/app_data.dart';

final appDataProvider = FutureProvider<AppData>((ref) async {
  final dbHelper = DatabaseHelper();

  // 🔥 Load once
  var trips = await dbHelper.getBusTrips();

  var grouped = dbHelper.groupBusTripsByOprsNo(trips);
  dbHelper.sortTripsBySeqNo(grouped);

  var graph = dbHelper.buildGraph(grouped);

  var stopIndex = dbHelper.buildStopIndex(grouped);
  addTransferEdges(graph, stopIndex);


  print("App fully initialized");

  return AppData(
    graph: graph,
    stopIndex: stopIndex,
    groupedTrips: grouped,
  );
});