import 'package:collection/collection.dart';
import 'package:planner_demo/models/edge.dart';

List<Map<String, double>> marksAlgorithm(
  Map<String, List<Edge>> graph,
  String source,
  String destination,
  Map<String, String> idToName,
) {
  Map<String, double> distances = {};
  Map<String, String?> previous = {};

  for (var node in graph.keys) {
    distances[node] = double.infinity;
    previous[node] = null;
  }

  distances[source] = 0;
  print("Starting Dijkstra: source=$source, destination=$destination");

  var pq = PriorityQueue<String>(
    (a, b) => distances[a]!.compareTo(distances[b]!),
  );

  pq.add(source);
  int stepCount = 0;

  while (pq.isNotEmpty) {
    String currentNode = pq.removeFirst();
     if (stepCount < 10) {
      print("Visiting node: $currentNode, current distance: ${distances[currentNode]}");
    }

    if (currentNode == destination) break;

    for (var edge in graph[currentNode] ?? []) {
      double alt = distances[currentNode]! + edge.distance;

      if (alt < distances[edge.toplaceId]!) {
        distances[edge.toplaceId] = alt;
        previous[edge.toplaceId] = currentNode;

        pq.add(edge.toplaceId);
        if (stepCount < 10) {
          print("Updated distance: ${edge.toplaceId} = $alt, prev=$currentNode");
        }
      }
    }
  }

  // BUILD PATH WITH NAMES
  List<Map<String, double>> path = [];

  String? curr = destination;

  int pathPrintLimit = 0;

  while (curr != null) {
    String? prevNode = previous[curr];

    double stepDistance = 0;

    if (prevNode != null) {
      stepDistance = distances[curr]! - distances[prevNode]!;
    }

    String placeName = idToName[curr] ?? curr;

    path.insert(0, {placeName: stepDistance});

     if (pathPrintLimit < 5) {
      print("Path step: $placeName -> $stepDistance km");
      pathPrintLimit++;
    }

    curr = prevNode;
  }

  print("Final path (first 5 steps if long): ${path.take(5).toList()}");
  return path;
}