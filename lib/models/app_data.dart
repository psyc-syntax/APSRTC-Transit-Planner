import 'package:planner_demo/models/bus_trip.dart';
import 'package:planner_demo/models/edge.dart';

class AppData {
  final Map<String, List<Edge>> graph;
  final Map<String, List<String>> stopIndex;
  final Map<String, List<BusTrip>> groupedTrips;

  AppData({
    required this.graph,
    required this.stopIndex,

    required this.groupedTrips,
  });
}