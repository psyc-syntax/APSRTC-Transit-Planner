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
        return RouteResultsDataPart(results: data!);
      } 
    );

    // return FutureBuilder<Result>(
    //   future: resultsGetter(
    //     ref.watch(startingPlaceIdProvider),
    //     ref.watch(destinationPlaceIdProvider),
    //     ref.watch(selectedStartTimeProvider),
    //   ),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return Scaffold(
    //         body: SafeArea(
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 16),
    //             child: Column(
    //               children: [
    //                 RouteResultsTitle(),
    //                 const SizedBox(height: 16),
    //                 RouteResultsLocationDetails(),

    //                 Expanded(
    //                   child: Center(
    //                     child: Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         CircularProgressIndicator(
    //                           color: Theme.of(context).colorScheme.primary,
    //                         ),
    //                         const SizedBox(height: 20),
    //                         Text(
    //                           "Finding the best trip...",
    //                           style: Theme.of(context).textTheme.titleSmall,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     }

    //     final results = snapshot.data!;

    //     return Scaffold(
    //       body: SafeArea(
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 16),
    //           child: Column(
    //             children: [
    //               RouteResultsTitle(),

    //               const SizedBox(height: 16),

    //               RouteResultsLocationDetails(),

    //               const SizedBox(height: 6),

    //               if(results.path.isNotEmpty && results.path.length > 1) RouteResultsTripParams(results: results),

    //               const SizedBox(height: 6),

    //               if(results.path.isNotEmpty && results.path.length > 1) StratTimeDetailsBlock(startTime: results.path[0].deptTime.toString()),

    //               const SizedBox(height: 24),

    //               Expanded(child: RouteResultTripCard(results: results)),

    //               if(results.path.isNotEmpty)Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
    //                 child: StartTripButton(),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
