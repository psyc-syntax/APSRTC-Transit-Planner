enum BusType{
  superLuxury,
  palleVelugu,
  ultraPallevelugu,
  ultraDeluxe,
  indraAc,
  volvo,
  express,
  garudaPlus,
}

class BusTrip {

  String serviceDocId;
  String oprsNo;
  String placeId;
  int seqNo;
  String placeName;
  String 	stationName;
  double latitude;
  double longitude;
  String scheduleArrTime;
  String scheduleDepTime;

  BusTrip({
    required this.serviceDocId,
    required this.oprsNo,
    required this.placeId,
    required this.seqNo,
    required this.placeName,
    required this.stationName,
    required this.latitude,
    required this.longitude,
    required this.scheduleArrTime,
    required this.scheduleDepTime,
  });


}