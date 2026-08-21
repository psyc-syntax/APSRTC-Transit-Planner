
import 'package:sqflite/sqlite_api.dart';

class AppData {
  final Database database;


  AppData({
    required this.database,
  });

  void operator [](String other) {}
}

class PathStop {
  final String placeId;
  final String placeName;
  final int arrivalTime;
  final int deptTime;
  final String oprsNo;
  final double? distance;
  final int? time;
  final String? serviceType;
  final String? vehicleNo;
  Map<String, String>? stopDetails;

  PathStop({
    required this.placeId,
    required this.placeName,
    required this.arrivalTime,
    required this.deptTime,
    required this.oprsNo,
    this.time,
    this.distance,
    this.serviceType,
    this.vehicleNo,
    this.stopDetails,
  });
}

class Result {
  final List<PathStop> path;
  final int time;

  Result(this.path, this.time);
}