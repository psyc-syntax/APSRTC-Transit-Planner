
import 'package:planner_demo/models/edge.dart';

class AppData {
  final Map<String, List<Edge>> graph;
  final Map<String, List<String>> stopIndex;


  AppData({
    required this.graph,
    required this.stopIndex,
  });

  void operator [](String other) {}
}