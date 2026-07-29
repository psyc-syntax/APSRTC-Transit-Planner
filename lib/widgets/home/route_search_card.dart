import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/home/location_selection_block.dart';

import 'package:planner_demo/widgets/route%20results/strat_time_details_block.dart';

class RouteSearchCard extends StatelessWidget{
  const RouteSearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          
          LocationSelectionBlock(),
      
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //   child:  StratTimeDetailsBlock(
          //     startTimeMin: DateTime.now().hour * 60 + DateTime.now().minute,
          //     startTime: (DateTime.now().hour * 60 + DateTime.now().minute,).toString(),
          //     ),
          // ),
          
      
          // SizedBox(height: 20,),
        ],
      ),
    );
  }
}