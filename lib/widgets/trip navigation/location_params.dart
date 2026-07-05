import 'package:flutter/material.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/models/date_data.dart';

import 'package:planner_demo/widgets/trip%20navigation/location_details_single_param.dart';

class TripNavLocationParams extends StatelessWidget {
  const TripNavLocationParams({
  super.key,
  required this.results
  });

  final Result? results;

  @override
  Widget build(BuildContext context) {

    DateTimeData dateTimeData = DateTimeData();

    int totalTime = dateTimeData.totalTimeCalc(results!);

    double totalDistance = dateTimeData.totalDistanceCalc(results!);
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TripNavLocationDetailsSingleParam(
              icon: Icons.alarm,
              title: "Start Time",
       
              paramDetail: dateTimeData.minToTime(results!.path[0].deptTime),
              iconColor: Theme.of(context).colorScheme.secondary,
            ),

            Container(
              width: 2,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: Theme.of(context).dividerColor,
            ),

            TripNavLocationDetailsSingleParam(
              icon: Icons.alarm,
              title: "Arrival Time",
       
              paramDetail: dateTimeData.minToTime(results!.path[results!.path.length - 1].deptTime),
              iconColor: Theme.of(context).colorScheme.primary,
            ),

            Container(
              width: 2,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: Theme.of(context).dividerColor,
            ),

            TripNavLocationDetailsSingleParam(
              icon: Icons.route,
              title: "Total Time",
     
              paramDetail: "${(totalTime / 60).toInt()}H ${(totalTime % 60).toInt()}M",
               iconColor: Theme.of(context).dividerColor,
            ),
          ],
        ),
      ),
    );
  }
}
