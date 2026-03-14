import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/shared/stop_basic_details_card.dart';

class NearbyStopsBlock extends StatelessWidget{
  const NearbyStopsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "POPULAR / NEARBY - STOPS",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontSize: 15,
          ),
        ),
        SizedBox(height: 8,),
        StopBasicDetailsCard(),
        StopBasicDetailsCard(),
        StopBasicDetailsCard(),
        StopBasicDetailsCard(),
        StopBasicDetailsCard(),
        StopBasicDetailsCard(),
        StopBasicDetailsCard(), 
        
      ],
    );
  }
}