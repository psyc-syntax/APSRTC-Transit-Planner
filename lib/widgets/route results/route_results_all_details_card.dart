import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/home/travel_date_selection_block.dart';
import 'package:planner_demo/widgets/route%20results/route_results_details.dart';

class RouteResultsAllDetailsCard extends StatelessWidget {
  const RouteResultsAllDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height:6, width: double.infinity),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RouteResultsDetails(),
            ),

            SizedBox(height: 16),

            TravelDateSelectionBlock(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
