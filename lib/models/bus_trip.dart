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

  //UNIQUE identity
  final String id;
  final String serviceNumber;

  //Trip id's for core graphlink
  final String sourceStopId;
  final String destinationStopId;

  //Graph node weights
  final double distanceInKm;
  final int durationInMinutes;
  final double ticketPrice;

  //Transit details
  final BusType busType;
  final String departureTime;
  final String arrivaltime;
  final List<String> viaStops;

  //Bus Status
  final bool isExpress;

  const BusTrip({

    required this.id,
    required this.serviceNumber,
    required this.sourceStopId,
    required this.destinationStopId,
    required this.distanceInKm,
    required this.durationInMinutes,
    required this.ticketPrice,
    required this.busType,
    required this.departureTime,
    required this.arrivaltime,
    required this.viaStops,
    required this.isExpress,
  });


}