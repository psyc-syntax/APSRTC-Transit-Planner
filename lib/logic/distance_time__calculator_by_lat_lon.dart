import 'dart:math';

/// Returns the estimated road distance in Kilometers
double getEstimatedRoadDistance(double lat1, double lon1, double lat2, double lon2) {
  // 1. Calculate straight-line distance (Haversine formula)
  double dLat = (lat2 - lat1) * pi / 180.0;
  double dLon = (lon2 - lon1) * pi / 180.0;

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * pi / 180.0) * cos(lat2 * pi / 180.0) *
      sin(dLon / 2) * sin(dLon / 2);

  double straightDistanceKm = 6371.0 * 2.0 * atan2(sqrt(a), sqrt(1 - a));

  // 2. Apply AP road detour multiplier based on distance
  double multiplier;
  if (straightDistanceKm < 15) {
    multiplier = 1.60; // City and town traffic (most curves/turns)
  } else if (straightDistanceKm < 80) {
    multiplier = 1.50; // State highways and inter-district roads
  } else {
    multiplier = 1.40; // Long-distance National Highways (straighter paths)
  }

  // 3. Return final estimated road distance
  return straightDistanceKm * multiplier;
}

double totalTimeByDistance(double distanceKm) {
  double averageSpeed;

  if (distanceKm <= 20) {
    averageSpeed = 25; // City
  } else if (distanceKm <= 100) {
    averageSpeed = 40; // Mixed roads
  } else if (distanceKm <= 300) {
    averageSpeed = 40; // Highway
  } else {
    averageSpeed = 55; // Long-distance highway
  }

  double baseTime = (distanceKm / averageSpeed) * 60;

  // Small overhead for signals, boarding, etc.
  double overhead;

  if (distanceKm <= 20) {
    overhead = baseTime * 0.20;
  } else if (distanceKm <= 100) {
    overhead = baseTime * 0.15;
  } else {
    overhead = baseTime * 0.10;
  }

  return baseTime + overhead;
}

double getEstimatedTimeByLatLon(double lat1, double lon1, double lat2, double lon2){
  
  double distance = getEstimatedRoadDistance(lat1, lon1, lat2, lon2);

  double time = totalTimeByDistance(distance);

  return time;

}