import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:planner_demo/models/app_data.dart';

final appdataProvider = FutureProvider<AppData>((ref) async {
  final dbhelper = DatabaseHelper();

  final trips = await dbhelper.getBusTrips();

  final grouped = dbhelper.groupBusTripsByOprsNo(trips);

  dbhelper.sortTripsBySeqNo(grouped);

  final graph = dbhelper.buildGraph(grouped);

  final stopIndex = dbhelper.buildStopIndex(grouped);

  addTransferEdges(graph, stopIndex);


  return AppData(
    graph: graph,
    stopIndex: stopIndex,
    groupedTrips: grouped,
  );
});