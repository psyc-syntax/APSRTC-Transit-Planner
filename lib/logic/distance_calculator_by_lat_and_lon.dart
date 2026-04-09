import 'dart:math';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {

  double dLat = _degreesToRadians(lat2 - lat1);
  double dLon = _degreesToRadians(lon2 - lon1);

  double a = _haversine(dLat, dLon, lat1, lat2);
  double angle = _haversineangle(a);
  return _haversineDistance(angle);


}

double _degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

double _haversine(double dLat, double dLon, double lat1, double lat2) {
  return pow(sin(dLat/ 2), 2) 
  + cos(_degreesToRadians(lat1)) 
  * cos(_degreesToRadians(lat2)) 
  * pow(sin(dLon / 2), 2);
}

double _haversineangle(double a) {
  return 2 * atan2(sqrt(a), sqrt(1 - a));
}

double _haversineDistance(double angle) {
  const double earthRadius = 6371;
  return earthRadius * angle;
}
