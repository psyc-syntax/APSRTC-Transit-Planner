import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:planner_demo/models/app_data.dart';
import 'package:planner_demo/providers/providers.dart';

import 'package:planner_demo/widgets/route%20results/loading_part_while_algorithm_running.dart';
import 'package:planner_demo/widgets/route%20results/result_data_part_after_algorithm_completed_execution.dart';

class RouteResultsScreen extends ConsumerWidget {
  const RouteResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync =
        ref.watch(routeResultsProvider);

    return resultsAsync.when(
      loading: () =>
          LoadingPartWhileAlgorithmRunning(),

      error: (error, stackTrace) => Scaffold(
        backgroundColor:
            Theme.of(context).colorScheme.surface,
        body: Center(
          child: Text("Error: $error"),
        ),
      ),

      data: (data) {
        final results =
            data.whereType<Result>().toList();

        // Only update the selected start time
        // when a valid route exists.
        if (results.isNotEmpty &&
            results[0].path.isNotEmpty) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) {
            ref
                .read(
                  tempSelectedStartTimeProvider
                      .notifier,
                )
                .state =
                results[0].path[0].deptTime;
          });
        }

        
        return RouteResultsDataPart(
          result: results,
        );
      },
    );
  }
}