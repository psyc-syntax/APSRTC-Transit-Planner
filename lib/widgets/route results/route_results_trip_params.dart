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
        RouteResultsTripParamContainer(param: "487.1KM", paramdetail: "Total Distance"),
        RouteResultsTripParamContainer(param: "4", paramdetail: "Stops"),

      ],
    );
  }

}