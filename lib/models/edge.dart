
class Edge {
  final String fromplaceId;
  final String toplaceId;
  final String fromPlaceName;
  final String toPlaceName;
  final double distance;
  final int travelTime; 

  Edge(
    {
      required this.fromplaceId, 
      required this.toplaceId,
      required this.fromPlaceName,
      required this.toPlaceName, 
      required this.distance, 
      required this.travelTime
    }
  );
}