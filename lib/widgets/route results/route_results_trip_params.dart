import 'package:flutter/material.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/widgets/route%20results/route_results_trip_param_container.dart';

class RouteResultsTripParams extends StatelessWidget{
  const RouteResultsTripParams({super.key, required this.results});

  final Result? results;
 
  @override
  Widget build(BuildContext context) {

    DateTimeData dateTimeData = DateTimeData();

    int totalTime = dateTimeData.totalTimeCalc(results!);
    
    String time = "~";

    if((totalTime / 60).toInt() > 0){
         time += "${(totalTime / 60).toInt()}H ";
    }
    
    if((totalTime % 60).toInt() > 0){
      time += "${(totalTime % 60).toInt()}M";
    }
    
  

    double totalDistance = dateTimeData.totalDistanceCalc(results!);
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RouteResultsTripParamContainer(
          param: time,
          paramdetail: "~Time"
        ),
        SizedBox(width: 6,),
      RouteResultsTripParamContainer(param: "${totalDistance.round()} Km", paramdetail: "~Distance"),
        SizedBox(width: 6,),
        RouteResultsTripParamContainer(param: "${(results!.path.length) - 2}", paramdetail: "Stops"),

        

      ],
    );
  }

}