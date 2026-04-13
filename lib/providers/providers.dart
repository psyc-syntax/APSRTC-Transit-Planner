

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/models/bus_trip.dart';
import 'package:planner_demo/models/edge.dart';
import 'package:planner_demo/providers/app_data_provider.dart';

final startingPlaceIdProvider = StateProvider<String>((ref) => "");
final startingPlaceNameProvider = StateProvider<String>((ref) => "Select Starting Stop");
final destinationPlaceIdProvider = StateProvider<String>((ref) => "");
final destinationPlaceNameProvider = StateProvider<String>((ref) => "Select Destination Stop");
final isstartingPlaceSelectedProvider = StateProvider<bool>((ref) => false);
final isdestinationPlaceSelectedProvider = StateProvider<bool>((ref) => false);

final runAlgorithmTriggerProvider = StateProvider<int>((ref) => 0);

final graphProvider = FutureProvider<Map<String, List<Edge>>>(
  (ref) async {
    final dbHelper = DatabaseHelper();

    var trips = await dbHelper.getBusTrips();
    print("Fetched trips: ${trips.length}");

    var grouped = dbHelper.groupBusTripsByOprsNo(trips);
    dbHelper.sortTripsBySeqNo(grouped);

    var graph = dbHelper.buildGraph(grouped);

    var stopIndex = dbHelper.buildStopIndex(grouped);
    addTransferEdges(graph, stopIndex);

    print("Graph built: ${graph.keys.length} nodes");

    return graph;
  },
);

final groupedTripsProvider = FutureProvider<Map<String, List<BusTrip>>>(
  (ref) async {
    final dbHelper = DatabaseHelper();
    var trips = await dbHelper.getBusTrips();
    return dbHelper.groupBusTripsByOprsNo(trips);
  },
);

final idToNameProvider = FutureProvider<Map<String, String>>(
  (ref) async {
    final dbHelper = DatabaseHelper();
    var trips = await dbHelper.getBusTrips();
    return dbHelper.buildIdToNameMap(trips);
  },
);

final stopIndexProvider = FutureProvider<Map<String, List<String>>>(
  (ref) async {
    final dbHelper = DatabaseHelper();
    var trips = await dbHelper.getBusTrips();
    var grouped = dbHelper.groupBusTripsByOprsNo(trips);
    return dbHelper.buildStopIndex(grouped);
  },
);

final startingpointsProvider = FutureProvider<List<String>>((ref) async {
  final idToName = await ref.watch(idToNameProvider.future);
  return idToName.keys.toList();
});

final destinationpointsProvider = FutureProvider<List<String>>((ref) async {
  final idToName = await ref.watch(idToNameProvider.future);
  return idToName.keys.toList();
});

// final markAlgorithmProvider =
//     FutureProvider<List<Map<String, double>>>((ref) async {

//   ref.watch(runAlgorithmTriggerProvider);

//   final sourceId = ref.watch(startingPlaceIdProvider);
//   final destinationId = ref.watch(destinationPlaceIdProvider);

//   if (sourceId.isEmpty || destinationId.isEmpty) return [];

//   final graph = await ref.watch(graphProvider.future);
//   final stopIndex = await ref.watch(stopIndexProvider.future);

//   final sourcenodes = stopIndex[sourceId] ?? [];
//   final destinationnodes = stopIndex[destinationId] ?? [];

  

//   return marksAlgorithm(graph, sourcenodes, destinationnodes);
// });
final markAlgorithmProvider =
    FutureProvider<List<Map<String, double>>>((ref) async {

  ref.watch(runAlgorithmTriggerProvider);

  final sourceId = ref.watch(startingPlaceIdProvider);
  final destinationId = ref.watch(destinationPlaceIdProvider);

  if (sourceId.isEmpty || destinationId.isEmpty) return [];

  final appData = await ref.watch(appDataProvider.future);

  final sourcenodes = appData.stopIndex[sourceId] ?? [];
  final destinationnodes = appData.stopIndex[destinationId] ?? [];

  print("Source nodes: $sourcenodes");
  print("Destination nodes: $destinationnodes");
  print("Selected sourceId: '$sourceId'");
  print("Available keys sample: ${appData.stopIndex.keys.take(5).toList()}");

  return marksAlgorithm(
    appData.graph,
    sourcenodes,
    destinationnodes,
  );
});




