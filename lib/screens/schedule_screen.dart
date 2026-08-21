import 'package:flutter/material.dart';


import 'package:planner_demo/widgets/home/route_search_card.dart';
import 'package:planner_demo/widgets/schedule/get_all_trips_button.dart';
import 'package:planner_demo/widgets/schedule/schedule_day_selection_block.dart';

import 'package:planner_demo/widgets/shared/top_title.dart';

class ScheduleScreen extends StatelessWidget{
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBody: true,
      body: SafeArea(
        top:true,
        bottom: false,
        right: true,
        left: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TopTitle(isbackNeeded: false, title: "Schedules"),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16, bottom: 8),
                      child: RouteSearchCard(inHome: false,),
                    ),

                    Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ScheduleDaySelectionBlock(startTimeMin:
                              DateTime.now().hour * 60 + DateTime.now().minute,
                          startTime: (
                            DateTime.now().hour * 60 + DateTime.now().minute,
                          ).toString(),
                          inHome: true,),
          ),

                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: GetAllTripsButton(),
                    ),


                    
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