import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/screens/route_results_screen.dart';

class FindOptimalRouteButton extends ConsumerWidget {
  const FindOptimalRouteButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bool isstartingPlaceSelected = ref.watch(
      isstartingPlaceSelectedProvider,
    );
    final String startingPlaceName = ref.watch(startingPlaceNameProvider);
    final String destinationPlaceName = ref.watch(destinationPlaceNameProvider);
    final bool isdestinationPlaceSelected = ref.watch(
      isdestinationPlaceSelectedProvider,
    );

    final now = DateTime.now();

    int time = now.hour * 60 + now.minute;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlpha(75),
            blurRadius: 16.0,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (isstartingPlaceSelected && isdestinationPlaceSelected) {
            ref.read(runAlgorithmTriggerProvider.notifier).state++;
            final result = await marksAlgorithm(
              ref.watch(startingPlaceIdProvider),
              ref.watch(destinationPlaceIdProvider),
              time,
            );

            if(context.mounted){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => RouteResultsScreen(
                    results: result
                  ),
                ),
              );
            }
          }

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (ctx) => TripNotificationScreen())
          // );
        },
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Plan Smart Trip", style: TextStyle(fontSize: 16)),
              Icon(Icons.bolt, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
