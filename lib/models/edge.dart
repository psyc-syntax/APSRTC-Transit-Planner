class Edge {
  final String fromplaceId;
  final String toplaceId;
  final int distance;
  final int travelTime; 

  Edge(
    {
      required this.fromplaceId, 
      required this.toplaceId, 
      required this.distance, 
      required this.travelTime
    }
  );
}