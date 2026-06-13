import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/widgets/route%20results/route_results_location_details.dart';
import 'package:planner_demo/widgets/route%20results/route_results_title.dart';
import 'package:planner_demo/widgets/route%20results/route_results_trip_params.dart';

class RouteResultsScreen extends ConsumerWidget {
  const RouteResultsScreen({super.key, this.results});

  final Result? results;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // TOP TITLE (Pinned, Not Scrollable)
              RouteResultsTitle(),
              SizedBox(height: 16),

              // SCROLLABLE CONTENT
              RouteResultsLocationDetails(),

              SizedBox(height: 6),

              RouteResultsTripParams(),

             results == null 
                ?const Center(child: Text("No path found"))
                :

              
                Expanded(
                child:
                    /// no route
                    ListView.builder(
                      itemCount: results?.path.length ?? 0,

                      itemBuilder: (context, index) {
                        final stop = results!.path[index];

                        return Row(
                          children: [
                            Text(stop.placeId),
                            Text(stop.placeName),
                            SizedBox(width: 8),
                            Text(stop.arrivalTime.toString()),
                          ],
                        );
                      },
                    ),
              ),

              // Trip cards  
            ],
          ),
        ),
      ),
    );
  }
}
