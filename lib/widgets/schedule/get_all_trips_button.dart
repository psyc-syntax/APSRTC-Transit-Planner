import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/screens/scheduled_trips_screen.dart';

class GetAllTripsButton extends ConsumerWidget {
  const GetAllTripsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isStartingPlaceSelected = ref.watch(
      isstartingPlaceSelectedProvider,
    );

    final bool isDestinationPlaceSelected = ref.watch(
      isdestinationPlaceSelectedProvider,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          // Uncomment if you want the glow effect
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).colorScheme.primary.withAlpha(75),
          //     blurRadius: 16,
          //     offset: const Offset(0, 8),
          //   ),
          // ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              bool isBothSelected =
                  !isStartingPlaceSelected && !isDestinationPlaceSelected;

              if (!isStartingPlaceSelected || !isDestinationPlaceSelected) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      actionsPadding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                      content: Text(
                        isBothSelected
                            ? "Select both starting and destination places"
                            : !isStartingPlaceSelected
                            ? "Select starting place"
                            : "Select destination place",
                        style: Theme.of(context).textTheme.bodyMedium,
                        // textAlign: TextAlign.center,
                      ),

                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Close",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    );
                  },
                );
                return;
              }

              ref
                  .read(runMorningScheduleAlgorithmTriggerProvider.notifier)
                  .state++;
              ref.read(isMorningScheduleAlgorithmRunning.notifier).state = true;

              ref
                  .read(runNoonScheduleAlgorithmTriggerProvider.notifier)
                  .state++;
              ref.read(isNoonScheduleAlgorithmRunning.notifier).state = true;

              ref
                  .read(runEveningScheduleAlgorithmTriggerProvider.notifier)
                  .state++;
              ref.read(isEveningScheduleAlgorithmRunning.notifier).state = true;

              if (ref.watch(isMorningScheduleAlgorithmRunning)) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ScheduledTripsScreen();
                    },
                  ),
                );
              }
            },

            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              ),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),

            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Get All Trips", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  const Icon(Icons.bolt, size: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
