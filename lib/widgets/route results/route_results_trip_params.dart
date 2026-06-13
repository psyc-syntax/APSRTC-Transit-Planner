import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/route%20results/route_results_trip_param_container.dart';

class RouteResultsTripParams extends StatelessWidget{
  const RouteResultsTripParams({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RouteResultsTripParamContainer(param: "12H 10M", paramdetail: "Total Time"),
        SizedBox(width: 8,),
        RouteResultsTripParamContainer(param: "487.12KM", paramdetail: "Total Distance"),
        SizedBox(width: 8,),
        RouteResultsTripParamContainer(param: "4", paramdetail: "Stops"),

      ],
    );
  }

}