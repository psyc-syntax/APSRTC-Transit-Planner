enum Hub {
  major,
  local,
}

class BusStop {
  const BusStop({
    required this.id,
    required this.name,
    required this.code,
    required this.hubType,
    required this.isDistrictHQ,
    required this.platfroms,
    required this.facilities,
    required this.latitude,
    required this.longitude,

  });

  //unique identity
  final String id;
  final String name;
  final String code;

  //hub dutails
  final Hub hubType;
  final bool isDistrictHQ;
  final int platfroms;
  final List <String> facilities;

  //location
  final double latitude;
  final double longitude;

}