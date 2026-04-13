import 'package:collection/collection.dart';
import 'package:planner_demo/models/edge.dart';

List<Map<String, double>> marksAlgorithm(
  Map<String, List<Edge>> graph,
  List<String> sourcenodes,
  List<String> destinationnodes,
) {
  Map<String, double> distances = {};
  Map<String, String?> previous = {};

  for (var node in graph.keys) {
    distances[node] = double.infinity;
    previous[node] = null;
  }

  // MULTIPLE SOURCES
  for (var source in sourcenodes) {
    distances[source] = 0;
  }

  var destinationSet = destinationnodes.toSet();

  var pq = PriorityQueue<String>(
    (a, b) => distances[a]!.compareTo(distances[b]!),
  );

  for (var source in sourcenodes) {
    pq.add(source);
  }

  String? foundDestination;
  int stepCount = 0;

  while (pq.isNotEmpty) {
    String currentNode = pq.removeFirst();

    if (stepCount < 10) {
      print(
        "Visiting node: $currentNode, current distance: ${distances[currentNode]}",
      );
    }
    stepCount++;

    // STOP WHEN ANY DESTINATION REACHED
    if (destinationSet.contains(currentNode)) {
      foundDestination = currentNode;
      print(
        "Reached destination node: $currentNode with distance ${distances[currentNode]}",
      );
      break;
    }

    for (var edge in graph[currentNode] ?? []) {
      double newDistance = distances[currentNode]! + edge.distance;

      //SAFE CHECK
      if (newDistance < (distances[edge.toplaceId] ?? double.infinity)) {
        distances[edge.toplaceId] = newDistance;
        previous[edge.toplaceId] = currentNode;
        pq.add(edge.toplaceId);

        if (stepCount < 10) {
          print(
            "Updated distance: ${edge.toplaceId} = $newDistance, prev=$currentNode",
          );
        }
      }
    }
  }

  // IF NO PATH
  if (foundDestination == null) {
    print("No path found to any destination node.");
    return [];
  }

  String destination = foundDestination;
  print(
    "Shortest distance to destination $destination: ${distances[destination]}",
  );

  //BUILD PATH
  List<Map<String, double>> path = [];
  String? curr = foundDestination;
  String? lastOprs;

  int pathPrintLimit = 0;

  while (curr != null && previous[curr] != null) {
    String placeName = curr;
    String? prevNode = previous[curr];
    

    String currOprs = curr.split("|")[1];

    double Distance = 0;

    if (prevNode != null) {
      for (var edge in graph[prevNode] ?? []) {
        if (edge.toplaceId == curr) {
          //USE EDGE NAME
          placeName = edge.toPlaceName ?? curr;
          Distance = distances[curr] ?? 0;
          break;
        }
      }
    }

    if (lastOprs == null || currOprs != lastOprs) {
      path.insert(0, {placeName: Distance});

      if (pathPrintLimit < 5) {
        print("Path step: $placeName -> $Distance km");
        pathPrintLimit++;
      }
    }

    lastOprs = currOprs;
    curr = prevNode;
  }

  print("Final path (first 5 steps if long): ${path.take(5).toList()}");

  return path;
}
