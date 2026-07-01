import 'package:flutter/material.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/widgets/route%20results/route_results_trip_param_container.dart';

class RouteResultsTripParams extends StatelessWidget{
  const RouteResultsTripParams({super.key, required this.results});

  final Result? results;
 
  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RouteResultsTripParamContainer(param: "12H 10M", paramdetail: "~Time"),
        SizedBox(width: 6,),
      RouteResultsTripParamContainer(param: "487.12KM", paramdetail: "~Distance"),
        SizedBox(width: 6,),
        RouteResultsTripParamContainer(param: "${(results!.path.length) - 2}", paramdetail: "Stops"),

      ],
    );
  }

}