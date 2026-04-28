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


  String oprsNo;
  String placeId;
  int seqNo;
  String placeName;
  double latitude;
  double longitude;
  int scheduleArrTimeInMin;
  int scheduleDepTimeInMin;

  BusTrip({

    required this.oprsNo,
    required this.placeId,
    required this.seqNo,
    required this.placeName,
    required this.latitude,
    required this.longitude,
    required this.scheduleArrTimeInMin,
    required this.scheduleDepTimeInMin,
  });


}