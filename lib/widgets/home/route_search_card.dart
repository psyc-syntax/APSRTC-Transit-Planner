import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/home/location_selection_block.dart';
import 'package:planner_demo/widgets/home/travel_date_selection_block.dart';

class RouteSearchCard extends StatelessWidget{
  const RouteSearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          
          LocationSelectionBlock(),
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TravelDateSelectionBlock(),
          ),
          
      
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}