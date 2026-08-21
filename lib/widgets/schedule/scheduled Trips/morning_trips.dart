import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:planner_demo/models/app_data.dart';
import 'package:planner_demo/providers/providers.dart';

import 'package:planner_demo/widgets/schedule/scheduled Trips/schedule_algorithm_loading_block.dart';
import 'package:planner_demo/widgets/schedule/scheduled Trips/schedule_trips_list.dart';

class ScheduleTrips extends ConsumerWidget {
  const ScheduleTrips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedScheduleProvider);
    final morningSchedule = ref.watch(morningScheduleTripsProvider);
    final noonSchedule = ref.watch(noonScheduleTripsProvider);
    final eveningSchedule = ref.watch(eveningScheduleTripsProvider);;

    final AsyncValue<List<Result?>> resultSync;

    switch (selected) {
      case ScheduleType.morning:
        resultSync = morningSchedule;
        break;

      case ScheduleType.afternoon:
        resultSync = noonSchedule;
        break;

      case ScheduleType.evening:
        resultSync = eveningSchedule;
        break;
    }

    return resultSync.when(
      loading: () => const LoadingPartWhileScheduleAlgorithmRunning(),

      error: (error, stackTrace) => Center(
          child: Text("Error: $error"),
        ),

      data: (data) {
        final validResults = data.whereType<Result>().toList();

        return ScheduleTripsList(
          result: validResults,
        );
      },
    );
  }
}