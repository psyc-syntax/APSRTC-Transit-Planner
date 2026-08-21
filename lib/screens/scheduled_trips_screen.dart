import 'package:flutter/material.dart';

import 'package:planner_demo/widgets/route%20results/route_results_location_details.dart';
import 'package:planner_demo/widgets/schedule/scheduled%20Trips/morning_trips.dart';
import 'package:planner_demo/widgets/schedule/scheduled%20Trips/time_divison_block.dart';
import 'package:planner_demo/widgets/shared/top_title.dart';

class ScheduledTripsScreen extends StatelessWidget{
  const ScheduledTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        right: true,
        left: true,
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TopTitle(isbackNeeded: true, title: "Scheduled Trips"),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
                      child: RouteResultsLocationDetails(),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: TimeDivisonBlock(),
                    ),

                    ScheduleTrips()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    
  }
}

