import 'package:planner_demo/models/edge.dart';

class GraphData {
  
  GraphData({
    required this.graph, 
    required this.stopIndex,
  });

  final Map<String, List<Edge>> graph;
  final Map<String, List<String>> stopIndex;

}
