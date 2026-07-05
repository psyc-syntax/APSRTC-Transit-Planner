import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/route%20results/route_results_location_details.dart';
import 'package:planner_demo/widgets/route%20results/route_results_title.dart';

class LoadingPartWhileAlgorithmRunning extends StatelessWidget {
  const LoadingPartWhileAlgorithmRunning({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
}