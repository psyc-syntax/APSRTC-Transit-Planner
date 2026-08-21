
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/models/app_data.dart';

import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/providers/providers.dart';


class TripNavLocationDetails extends ConsumerWidget {
  const TripNavLocationDetails({super.key, required this.results});

  final Result results;

  @override
  Widget build(BuildContext context, ref) {

    DateTimeData dateTimeData = DateTimeData();

    double totalDistance = dateTimeData.totalDistanceCalc(results);

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
                    
                    //from Icon
                    Icon(Icons.radio_button_on, color: Colors.green, size: 16),
        
                    //vertical line
                    Container(
                      width: 2,
                      height: 34,
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
                      Text("Source", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 10
                    ),),
        
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 4, left: 0, right: 8),
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
                       Text("Destination", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 10
                    ),),
                    ],
                  ),
                ),


                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary.withAlpha(40),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                          width: 2
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "MARK",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.secondary
                          )
                          ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Text("${totalDistance.round()} km", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14,
                    ),),


                    Text("~Distance", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 10
                    ),)
                  ],
                )
                
                
              ],
            ),

            
          ],
        ),
      ),
    );
  }
}
