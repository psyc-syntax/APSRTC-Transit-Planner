
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/providers/app_data_provider.dart';

final startingPlaceIdProvider = StateProvider<String>((ref) => "");
final startingPlaceNameProvider = StateProvider<String>((ref) => "Select starting point");
final destinationPlaceIdProvider = StateProvider<String>((ref) => "");
final destinationPlaceNameProvider = StateProvider<String>((ref) => "Select destination point");
final isstartingPlaceSelectedProvider = StateProvider<bool>((ref) => false);
final isdestinationPlaceSelectedProvider = StateProvider<bool>((ref) => false);

final runAlgorithmTriggerProvider = StateProvider<int>((ref) => 0); 


// final graphProvider = FutureProvider<Map<String, List<Edge>>>((ref) async {
//   final db = DatabaseHelper();

//   var trips = await db.getBusTrips();
//   var grouped = db.groupBusTripsByOprsNo(trips);

//   db.sortTripsBySeqNo(grouped);

//   var graph = db.buildGraph(grouped);
//   var stopIndex = db.buildStopIndex(grouped);

//   addTransferEdges(graph, stopIndex);

//   return graph;
// });

// final stopIndexProvider =
//     FutureProvider<Map<String, List<String>>>((ref) async {
//   final db = DatabaseHelper();
//   var trips = await db.getBusTrips();
//   var grouped = db.groupBusTripsByOprsNo(trips);
//   return db.buildStopIndex(grouped);
// });

final markAlgorithmProvider =
    FutureProvider<List<Map<String, double>>>((ref) async {
  ref.watch(runAlgorithmTriggerProvider);

  // WATCH SOURCE AND DESTINATION
  final source = ref.watch(startingPlaceIdProvider);
  final dest = ref.watch(destinationPlaceIdProvider);


  // SAFETY CHECK
  if (source.isEmpty || dest.isEmpty) return [];

  // GET APP DATA
  final data = await ref.watch(appdataProvider.future);

  // EXTRACT GRAPH AND STOP INDEX
  final graph = data.graph;
  final stopIndex = data.stopIndex;

  
  final sources = stopIndex[source] ?? [];
  final destinations = stopIndex[dest] ?? [];

  return marksAlgorithm(graph, sources, destinations);
});