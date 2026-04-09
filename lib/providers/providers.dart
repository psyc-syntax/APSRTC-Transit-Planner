

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/models/bus_trip.dart';
import 'package:planner_demo/models/edge.dart';
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
    print("Graph built: ${graph.keys.length} nodes");

    // Print first 5 keys and first 3 edges for each key
    int nodeCount = 0;
    for (var entry in graph.entries) {
      print("${entry.key} -> ${entry.value.take(3).map((e) => "${e.toplaceId}:${e.distance}").toList()}");
      nodeCount++;
      if (nodeCount >= 5) break;
    }

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
    var map = dbHelper.buildIdToNameMap(trips);

    print("idToName map (first 5 entries): ${map.entries.take(5).toList()}");
    return map;
  },

);

final markAlgorithmProvider =
  FutureProvider<List<Map<String, double>>>((ref) async {

  ref.watch(runAlgorithmTriggerProvider);

  final sourceId = ref.watch(startingPlaceIdProvider);
  final destinationId = ref.watch(destinationPlaceIdProvider);
  print("Algorithm triggered: sourceId=$sourceId, destinationId=$destinationId");


  if (sourceId.isEmpty || destinationId.isEmpty) return [];

  final graph = await ref.watch(graphProvider.future);
  final idToName = await ref.watch(idToNameProvider.future);

  return marksAlgorithm(graph, sourceId, destinationId, idToName);
});



