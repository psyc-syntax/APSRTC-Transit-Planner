import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/screens/trip_navigation_screen.dart';


import 'package:planner_demo/widgets/route%20results/route_result_trip_card.dart';
import 'package:planner_demo/widgets/route%20results/route_results_location_details.dart';
import 'package:planner_demo/widgets/route%20results/smart_suggestion_block.dart';
import 'package:planner_demo/widgets/shared/top_title.dart';
import 'package:planner_demo/widgets/route%20results/route_results_trip_params.dart';
import 'package:planner_demo/widgets/route%20results/start_trip_button.dart';
import 'package:planner_demo/widgets/route%20results/strat_time_details_block.dart';

class RouteResultsDataPart extends ConsumerWidget {
  const RouteResultsDataPart({super.key, required this.results});

  final Result results;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTimeData dateTimeData = DateTimeData();
    final theme = Theme.of(context);
    final Color bgColor = theme.colorScheme.surface;
   

    if (results.path.isNotEmpty) {
      print(
        "RouteResultsDataPart rebuilt: "
        "first departure = ${results.path.first.deptTime}, "
        "destination arrival = ${results.path.last.arrivalTime}",
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,
      floatingActionButton: results.path.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 32,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: StartTripButton(results: results),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          // Layer 1: Scrollable Route Content
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const TopTitle(isbackNeeded: true, title: "Trip Result"),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      // 140px bottom padding clears both the bottom gradient and the FAB button
                      padding: const EdgeInsets.only(bottom: 140.0),
                      child: Column(
                        children: [
                          const RouteResultsLocationDetails(),
                          const SizedBox(height: 6),
                          if (results.path.isNotEmpty && results.path.length > 1)
                            RouteResultsTripParams(results: results),
                          if (results.path.isNotEmpty && results.path.length > 1)
                            const SizedBox(height: 6),
                          if (results.path.isNotEmpty && results.path.length > 1)
                            StratTimeDetailsBlock(
                              startTime: results.path[0].deptTime.toString(),
                              startTimeMin: results.path[0].deptTime,
                              inHome: false,
                            ),

                          SizedBox(height: 16,),


                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                return TripNavigationScreen(results: results);
                              }));
                            },
                            child: RouteResultTripCard(
                              results: results,
                              selectedtime: (dateTimeData.timeToMin(DateTime.now())).toString(),
                            ),
                          ),

                          SizedBox(height: 50,),

                          SmartSuggestionBlock(),

                          // SizedBox(height: 100,),

                         

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Layer 2: Telegram-Style Bottom Scrim Gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 140, // Fade height spanning behind the bottom floating action button
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      bgColor.withOpacity(0.0),
                      bgColor.withOpacity(0.8),
                      bgColor,
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}