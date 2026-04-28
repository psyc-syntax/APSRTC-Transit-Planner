import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/route%20results/route_result_trip_card.dart';
import 'package:planner_demo/widgets/route%20results/route_results_location_details.dart';
import 'package:planner_demo/widgets/route%20results/route_results_title.dart';
import 'package:planner_demo/widgets/route%20results/route_results_trip_params.dart';

class RouteResultsScreen extends StatelessWidget {
  const RouteResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              // TOP TITLE (Pinned, Not Scrollable)
              RouteResultsTitle(),
              SizedBox(height: 16),

              // SCROLLABLE CONTENT
              RouteResultsLocationDetails(),

              SizedBox(height: 6,),

              RouteResultsTripParams(),

              
                            
              // Trip cards
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    RouteResultTripCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}