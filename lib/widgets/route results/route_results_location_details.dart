import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/screens/stop_search_screen.dart';

class RouteResultsLocationDetails extends ConsumerWidget {
  const RouteResultsLocationDetails({
    super.key,
   
    });

  

  @override
  Widget build(BuildContext context, ref) {

   

    //provider starting-destination place names
    final String startingPlaceName = ref.watch(startingPlaceNameProvider);
    final String destinationPlaceName = ref.watch(destinationPlaceNameProvider);

    //Widget container of location details
    return Container(
      decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.surfaceContainerHighest,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Theme.of(context).dividerColor,
            )
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
                      GestureDetector(

                        onTap: () {
                          
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (ctx){
                              return StopSearchScreen(isbackneeded: true, isStartingStop: true);
                            })
                            );
                        },
                        child: Text(
                          startingPlaceName,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                        ),
                      ),
        
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 8),
                        child: Container(
                          width: double.infinity,
                          height: 2,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
        
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (ctx){
                              return StopSearchScreen(isbackneeded: true, isStartingStop: false);
                            })
                          );
                        },
                        child: Text(
                          destinationPlaceName,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    
                    String startingPlaceId = ref.read(startingPlaceIdProvider);
                            String destinationPlaceId = ref.read(destinationPlaceIdProvider);
                            String startingPlaceName = ref.read(startingPlaceNameProvider);
                            String destinationPlaceName = ref.read(destinationPlaceNameProvider);
                            ref.read(startingPlaceNameProvider.notifier).state = destinationPlaceName;
                            ref.read(destinationPlaceNameProvider.notifier).state = startingPlaceName;
                            ref.read(startingPlaceIdProvider.notifier).state = destinationPlaceId;
                            ref.read(destinationPlaceIdProvider.notifier).state = startingPlaceId;
                            ref.read(runAlgorithmTriggerProvider.notifier).state++;
                            ref.read(isMarkAlgorithmRunning.notifier).state = true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 4),
                    child: Icon(Icons.swap_vert, size: 28),
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
