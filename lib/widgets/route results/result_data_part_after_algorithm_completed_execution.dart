import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/screens/trip_navigation_screen.dart';
import 'package:planner_demo/widgets/route%20results/note_suggestion_block.dart';
import 'package:planner_demo/widgets/route%20results/route_results_location_details.dart';
import 'package:planner_demo/widgets/route%20results/route_results_trip_timeline_cart.dart';
import 'package:planner_demo/widgets/route%20results/smart_suggestion_block.dart';
import 'package:planner_demo/widgets/route%20results/start_trip_button.dart';
import 'package:planner_demo/widgets/shared/top_title.dart';
import 'package:planner_demo/widgets/route%20results/strat_time_details_block.dart';
import '../../models/app_data.dart';
import '../../providers/providers.dart';

class RouteResultsDataPart extends ConsumerWidget {
  const RouteResultsDataPart({super.key, required this.result});

  final List<Result> result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final theme = Theme.of(context);
    final Color bgColor = theme.colorScheme.surface;

    // ---------------------------------------------------------
    // SHOW MORE / SHOW LESS
    // ---------------------------------------------------------

    final bool showAllTrips = ref.watch(showAllTripsProvider);

    // ---------------------------------------------------------
    // CHECK WHETHER A VALID TRIP EXISTS
    // ---------------------------------------------------------

    final bool hasTrips = result.isNotEmpty && result[0].path.isNotEmpty;

    // ---------------------------------------------------------
    // TRIPS TO DISPLAY
    //
    // Default:
    //      only first trip
    //
    // Show More:
    //      all trips
    // ---------------------------------------------------------

    final List<Result> tripsToDisplay = showAllTrips
        ? result
        : result.take(1).toList();

    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,

      // =======================================================
      // FLOATING ACTION BUTTON
      // =======================================================
      floatingActionButton: hasTrips
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 32),

              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: ShowMoreTripsButton(
                  showAllTrips: showAllTrips,

                  onPressed: () {
                    ref.read(showAllTripsProvider.notifier).state =
                        !showAllTrips;
                  },
                ),
              ),
            )
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // =======================================================
      // BODY
      // =======================================================
      body: Stack(
        children: [
          SafeArea(
            bottom: false,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Column(
                children: [
                  // =================================================
                  // TOP TITLE
                  // =================================================
                  const TopTitle(isbackNeeded: true, title: "Trip Result"),

                  const SizedBox(height: 16),

                  // =================================================
                  // MAIN SCROLL
                  // =================================================
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),

                      padding: const EdgeInsets.only(bottom: 140),

                      child: Column(
                        children: [
                          // =========================================
                          // LOCATION DETAILS
                          //
                          // ALWAYS DISPLAY
                          // =========================================
                          const RouteResultsLocationDetails(),

                          const SizedBox(height: 6),

                          // =========================================
                          // START / SELECTION TIME
                          //
                          // ALWAYS DISPLAY
                          // =========================================
                          if (hasTrips)
                            StratTimeDetailsBlock(
                              startTime: result[0].path[0].deptTime.toString(),

                              startTimeMin: result[0].path[0].deptTime,

                              inHome: false,
                            )
                          else
                            const StratTimeDetailsBlock(
                              startTime: "",
                              startTimeMin: 0,
                              inHome: false,
                            ),

                          // const SizedBox(height: 16),

                          // =========================================
                          // ROUTE PARAMETERS
                          //
                          // ONLY WHEN ROUTE EXISTS
                          // =========================================

                          // if (hasTrips &&
                          //     result[0]
                          //             .path
                          //             .length >
                          //         1)
                          //   RouteResultsTripParams(
                          //     results: result[0],
                          //   ),

                          // if (hasTrips &&
                          //     result[0]
                          //             .path
                          //             .length >
                          //         1)
                          //   const SizedBox(height: 6),

                          // =========================================
                          // NO TRIPS
                          // =========================================
                          if (!hasTrips)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 50,
                                left: 20,
                                right: 20,
                              ),

                              child: Column(
                                children: [
                                  Icon(
                                    Icons.alt_route,
                                    size: 70,
                                    color: theme.colorScheme.primary,
                                  ),

                                  const SizedBox(height: 20),

                                  Text(
                                    "No Trips Found",

                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    "We couldn't find any bus trips for the selected locations and time.",

                                    textAlign: TextAlign.center,

                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),

                          // =========================================
                          // TRIP LIST
                          //
                          // DEFAULT -> 1
                          // SHOW MORE -> ALL
                          // =========================================
                          if (hasTrips)
                            ListView.builder(
                              shrinkWrap: true,

                              physics: const NeverScrollableScrollPhysics(),

                              itemCount: tripsToDisplay.length,

                              itemBuilder: (context, index) {
                                final Result trip = tripsToDisplay[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return TripNavigationScreen(
                                            results: trip,
                                          );
                                        },
                                      ),
                                    );
                                  },

                                  child: RouteResultsTripTimelineCart(
                                    result: result[index],
                                  ),
                                );
                              },
                            ),

                          const SizedBox(height: 30),

                          // =========================================
                          // SMART SUGGESTIONS
                          // =========================================
                          SmartSuggestionBlock(),
                          SizedBox(height: 6,),
                          NoteSuggestionBlock(),
                          
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =======================================================
          // BOTTOM GRADIENT
          // =======================================================
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 140,

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
