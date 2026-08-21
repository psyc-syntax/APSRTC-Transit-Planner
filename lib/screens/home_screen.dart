import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/home/find_optimal_route_button.dart';
import 'package:planner_demo/widgets/home/app_logo_text.dart';
import 'package:planner_demo/widgets/home/route_search_card.dart';

import 'package:planner_demo/widgets/route%20results/strat_time_details_block.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          top: true,
          bottom: false,
          left: true,
          right: true,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //top title(offline engine ready, database info)
              // TopTitle(),
              // HorizontalLine(),

              //main title (app icon and dropdown menu)
              MainTitle(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: RouteSearchCard(inHome: true,), //trip details selection card
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          left: 18.0,
                          right: 18.0,
                          top: 8,
                        ),
                        child: StratTimeDetailsBlock(
                          startTimeMin:
                              DateTime.now().hour * 60 + DateTime.now().minute,
                          startTime: (
                            DateTime.now().hour * 60 + DateTime.now().minute,
                          ).toString(),
                          inHome: true,
                        ),
                      ),

                      // optimal route button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),

                        // find optimal route button
                        child: FindOptimalRouteButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
