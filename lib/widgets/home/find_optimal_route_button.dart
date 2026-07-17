import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/helpers/date_time_update_helper.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/screens/route_results_screen.dart';

class FindOptimalRouteButton extends ConsumerWidget {
  const FindOptimalRouteButton({super.key});

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
              if (!isStartingPlaceSelected ||
                  !isDestinationPlaceSelected) {
                return;
              }

              if (ref.read(tempDateCategoryProvider) == "Today") {
                ref.read(tempSelectedStartTimeProvider.notifier).state =
                    DateTime.now().hour * 60 +
                        DateTime.now().minute;
              } else {
                ref.read(tempSelectedStartTimeProvider.notifier).state = 480;
              }

              updateDateAndTime(ref);

              ref.read(runAlgorithmTriggerProvider.notifier).state++;

              ref.read(isMarkAlgorithmRunning.notifier).state = true;

              if (ref.read(isMarkAlgorithmRunning)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RouteResultsScreen(),
                  ),
                );
              }
            },

            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
              ),
            ),

            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Start Trip", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.bolt,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}