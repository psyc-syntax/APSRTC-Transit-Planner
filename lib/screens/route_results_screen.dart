import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/widgets/route%20results/route_result_trip_card.dart';
import 'package:planner_demo/widgets/route%20results/route_results_location_details.dart';
import 'package:planner_demo/widgets/route%20results/route_results_title.dart';
import 'package:planner_demo/widgets/route%20results/route_results_trip_params.dart';
import 'package:planner_demo/widgets/route%20results/start_trip_button.dart';

class RouteResultsScreen extends ConsumerWidget {
  const RouteResultsScreen({super.key});

  Future<Result> resultsGetter(
    String sourcePlaceId,
    String destinationPlaceId,
    int startTime,
  ) async {
    return await marksAlgorithm(sourcePlaceId, destinationPlaceId, startTime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final time = now.hour * 60 + now.minute;

    return FutureBuilder<Result>(
      future: resultsGetter(
        ref.read(startingPlaceIdProvider),
        ref.read(destinationPlaceIdProvider),
        time,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    RouteResultsTitle(),
                    const SizedBox(height: 16),
                    RouteResultsLocationDetails(),

                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Finding the best trip...",
                              style: Theme.of(context).textTheme.titleSmall,
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

        final results = snapshot.data!;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  RouteResultsTitle(),
                  const SizedBox(height: 16),
                  RouteResultsLocationDetails(),
                  const SizedBox(height: 6),
                  if(results.path.isNotEmpty) RouteResultsTripParams(results: results),
                  const SizedBox(height: 24),
                  Expanded(child: RouteResultTripCard(results: results)),

                  if(results.path.isNotEmpty)Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                    child: StartTripButton(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
