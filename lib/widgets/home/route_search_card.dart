import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/home/find_optimal_route_button.dart';
import 'package:planner_demo/widgets/home/location_selection_block.dart';
import 'package:planner_demo/widgets/home/travel_date_selection_block.dart';

class RouteSearchCard extends StatelessWidget{
  const RouteSearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16.0,
            spreadRadius: 4.0,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
        child: Column(
          children: [
            
            LocationSelectionBlock(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TravelDateSelectionBlock(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0, 
                vertical: 16,
              ),

              
              // find optimal route button
              child: FindOptimalRouteButton(),
            ),

            SizedBox(height: 4,),
          ],
        ),
      ),
    );
  }
}