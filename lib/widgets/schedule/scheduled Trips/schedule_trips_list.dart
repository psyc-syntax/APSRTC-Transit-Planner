import 'dart:math';

import 'package:flutter/material.dart';

import 'package:planner_demo/models/app_data.dart';
import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/screens/trip_navigation_screen.dart';

import 'package:planner_demo/widgets/schedule/scheduled%20Trips/schedule_trip_card_timeline.dart';

class ScheduleTripsList extends StatelessWidget {
  const ScheduleTripsList({super.key, required this.result});

  final List<Result> result;

  @override
  Widget build(BuildContext context) {

    DateTimeData dateTimeData = DateTimeData();
    

    if (result.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Text("No trips available for this time range."),
        ),
      );
    }

    double totalDistance;
    int totalTime;

    return ListView.builder(
      itemCount: result.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      
      itemBuilder: (context, index) {

        totalDistance = dateTimeData.totalDistanceCalc(result[index]);
        int totalTime = dateTimeData.totalTimeCalc(result[index]);

    String totalStringTime = "";

    if((totalTime / 60).toInt() > 0){
         totalStringTime += "${(totalTime / 60).toInt()}H ";
    }
    
    if((totalTime % 60).toInt() > 0){
      totalStringTime += "${(totalTime % 60).toInt()}M";
    }

        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return TripNavigationScreen(results: result[index]);
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Theme.of(context).dividerColor),
                
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ScheduleTripCardTimeline(
                        results: result[index],
                        selectedtime: "0",
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildParam("${max(result[index].path.length - 1, 1)} BUS${result[index].path.length > 2? "ES": ""}", Icons.directions_bus, context),
                        SizedBox(height: 4,),
                        _buildParam(totalStringTime, Icons.alarm, context),
                        SizedBox(height: 4,),
                        _buildParam("${totalDistance.round()} Km", Icons.route, context),
                        SizedBox(height: 4,),

                      ],
                    ),

                    SizedBox(width: 8,),
                    Icon(Icons.arrow_forward_ios, size: 16,)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildParam(String title, IconData icon, context){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Icon(icon, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
    SizedBox(width: 4,),
    Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(
      fontSize: 12
    ),),
  ],
  );
}
