import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';

class RouteResultsLocationDetails extends ConsumerWidget {
  const RouteResultsLocationDetails({super.key});

  @override
  Widget build(BuildContext context, ref) {

    //provider starting-destination place names
    final String startingPlaceName = ref.watch(startingPlaceNameProvider);
    final String destinationPlaceName = ref.watch(destinationPlaceNameProvider);

    //Widget container of location details
    return Container(
      decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            )
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                //left part with icons and vertical line
                Column(
                  children: [
                    SizedBox(height: 4),
                    //from Icon
                    Icon(Icons.radio_button_on, color: Colors.green, size: 16),
        
                    //vertical line
                    Container(
                      width: 2,
                      height: 24,
                      color: Theme.of(context).dividerColor,
                    ),
        
                    //too Icon
                    Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 22,
                    ),
                  ],
                ),
        
                SizedBox(width: 10),
        
                //right part with location names and horizontal line
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        startingPlaceName,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                      ),
        
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: double.infinity,
                          height: 2,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
        
                      Text(
                        destinationPlaceName,
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 4),
                  child: Icon(Icons.swap_vert, size: 32),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
