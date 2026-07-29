import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/widgets/route%20results/loading_part_while_algorithm_running.dart';
import 'package:planner_demo/widgets/route%20results/result_data_part_after_algorithm_completed_execution.dart';

class RouteResultsScreen extends ConsumerWidget {
  const RouteResultsScreen({super.key});

  // Future<Result> resultsGetter(
  //   String sourcePlaceId,
  //   String destinationPlaceId,
  //   int startTime,
  // ) async {
  //   return await marksAlgorithm(sourcePlaceId, destinationPlaceId, startTime);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(routeResultsProvider);

    return resultsAsync.when(
      loading: () => LoadingPartWhileAlgorithmRunning(),
      error: (error, stackTrace) =>
          
          Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Center(child: Text("Error: $error"))),

      data: (data) {
         WidgetsBinding.instance.addPostFrameCallback((_) {

    if (data != null && data.path.isNotEmpty) {
      
      ref.read(tempSelectedStartTimeProvider.notifier).state =
          data.path[0].deptTime;
    }

  });
        
        return RouteResultsDataPart(results: data!);
      } 
    );

  }
}
