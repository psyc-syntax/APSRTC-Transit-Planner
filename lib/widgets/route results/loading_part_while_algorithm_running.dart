import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:planner_demo/widgets/route%20results/route_results_location_details.dart';

import 'package:planner_demo/widgets/shared/top_title.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TopTitle(isbackNeeded: true, title: ""),
                    const SizedBox(height: 16),
                    RouteResultsLocationDetails(),

                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // CircularProgressIndicator(
                            //   color: Theme.of(context).colorScheme.primary,
                            // ),
                            SizedBox(
            width: 280,
            height: 180,
            child: Lottie.asset(
              'assets/markbus_route_finding_simple.json',
              repeat: true,
            ),
          ),
                            // const SizedBox(height: 20),
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