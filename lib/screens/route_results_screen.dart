import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/route%20results/route_result_trip_card.dart';
import 'package:planner_demo/widgets/route%20results/route_results_all_details_card.dart';
import 'package:planner_demo/widgets/route%20results/route_results_title.dart';

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
            children: [
              
              // TOP TITLE (Pinned, Not Scrollable)
              RouteResultsTitle(),
              SizedBox(height: 16),

              // SCROLLABLE CONTENT
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 16.0,
                      spreadRadius: 4.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: RouteResultsAllDetailsCard(),
              ),
                            
              SizedBox(height: 16),
                            
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