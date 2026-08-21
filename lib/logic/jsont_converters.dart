

import '../models/app_data.dart';

Map<String, dynamic> resultToJson(Result result, String id){
 List<Map<String, dynamic>> pathJosn = [];
 

 for(final stop in result.path){
  pathJosn.add({
    "placeId": stop.placeId,
      "placeName": stop.placeName,
      "arrivalTime": stop.arrivalTime,
      "deptTime": stop.deptTime,
      "oprsNo": stop.oprsNo,
      "distance": stop.distance,
      "time": stop.time,
      "serviceType": stop.serviceType,
      "vehicleNo": stop.vehicleNo,
 });
 }
return {
  "time" : result.time,
  "path" : pathJosn
};
}


Result resultFromJson(
    Map<String,dynamic> json){

  List<PathStop> path=[];

  List<dynamic> list=json["path"];

  for(final stop in list){

    path.add(

      PathStop(

        placeId:stop["placeId"],

        placeName:stop["placeName"],

        arrivalTime:stop["arrivalTime"],

        deptTime:stop["deptTime"],

        oprsNo:stop["oprsNo"],

        distance:(stop["distance"] as num?)?.toDouble(),

        time:stop["time"],

        serviceType:stop["serviceType"],

        vehicleNo:stop["vehicleNo"],

      ),

    );

  }

  return Result(

    path,

    json["time"],

  );

}


