import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/screens/stop_search_screen.dart';

class LocationSelectionBlock extends ConsumerWidget {
  const LocationSelectionBlock({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final startingPlaceName = ref.watch(startingPlaceNameProvider);
    final destinationPlaceName = ref.watch(destinationPlaceNameProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //left side icons
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10, top: 8),
          child: Column(
            children: [
              //from Icon
              Icon(
                Icons.radio_button_on,
                color: Theme.of(context).colorScheme.primary,
                size: 15,
              ),

              //vertical line
              Container(
                width: 2,
                height: 40,
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
        ),

        //right side maincontent
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "From",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(
                    height: 0.9,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                SizedBox(height: 4),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StopSearchScreen(
                          isbackneeded: true,
                          isStartingStop: true,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    startingPlaceName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      letterSpacing: 0,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                ),

                SizedBox(height: 8),

                //horizontal line
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    height: 2,
                    width: double.infinity,
                    color: Theme.of(context).dividerColor,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "To",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(height: 0.9, overflow: TextOverflow.ellipsis),
                  
                ),

                SizedBox(height: 4),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StopSearchScreen(
                          isbackneeded: true,
                          isStartingStop: false,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    destinationPlaceName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      letterSpacing: 0,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            // Swap the starting and destination place names
            String startingPlaceId = ref.read(startingPlaceIdProvider);
            String destinationPlaceId = ref.read(destinationPlaceIdProvider);

            String startingPlaceName = ref.read(startingPlaceNameProvider);

            String destinationPlaceName = ref.read(
              destinationPlaceNameProvider,
            );

            ref.read(startingPlaceNameProvider.notifier).state =
                destinationPlaceName;

            ref.read(destinationPlaceNameProvider.notifier).state =
                startingPlaceName;
                
            ref.read(startingPlaceIdProvider.notifier).state =
                destinationPlaceId;

            ref.read(destinationPlaceIdProvider.notifier).state =
                startingPlaceId;

          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 4),
            child: Icon(Icons.swap_vert, size: 30),
          ),
        ),
      ],
    );
  }
}
