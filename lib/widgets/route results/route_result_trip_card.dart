import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/widgets/route%20results/circular_coloured_icon.dart';
import 'package:planner_demo/widgets/route%20results/strat_time_details_block.dart';

class RouteResultTripCard extends ConsumerWidget {
  const RouteResultTripCard({
    super.key, 
    required this.results, 
    required this.selectedtime,
  });

  final Result? results;
  final String selectedtime;

  @override
  Widget build(BuildContext context, ref) {
    final trip = results?.path ?? [];

    DateTimeData dateTimeData = DateTimeData();



    
    if (trip.isEmpty) {
      return Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,


        children: [
          

          StratTimeDetailsBlock(
            startTime: selectedtime, 
            startTimeMin: ref.watch(selectedStartTimeProvider),
            inHome: false,
          ),


          Text("No route found!!"),

          SizedBox(height: 80,)

        ],
      );

    }

    return ListView.builder(
      shrinkWrap: true, 
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: trip.length,
      itemBuilder: (context, index) {
        final stop = trip[index];

        final bool isFirst = index == 0;
        final bool isLast = index == trip.length - 1;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
          
              /// ARRIVAL TIME
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !isFirst
                        ? Text(
                            dateTimeData.minToTime(stop.arrivalTime),
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontSize: 12, letterSpacing: 0.1),
                          )
                        : Text(
                            "Start",
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontSize: 16, color: Colors.green),
                          ),
          
                    if (!isFirst)
                      Text(
                        "arrival",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
          
              /// TIMELINE
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    if (!isFirst)
                      Container(
                        width: 2,
                        height: 4,
                        color: Theme.of(context).dividerColor,
                      ),
          
                    isFirst
                        ? CircularColouredIcon(
                            iconData: Icons.directions_walk,
                            color: Colors.green,
                          )
                        : !isLast
                        ? CircularColouredIcon(
                            iconData: Icons.bus_alert,
                            color: Theme.of(context).dividerColor,
                            isfillColor: false,
                          )
                        : CircularColouredIcon(
                            iconData: Icons.directions_transit,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 40,
                        color: Theme.of(context).dividerColor,
                      ),
                  ],
                ),
              ),
          
              /// STOP DETAILS
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stop.placeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                    ),
          
                    const SizedBox(height: 4),
          
                    Text(
                      isFirst
                          ? "Boarding Stop"
                          : isLast
                          ? "Destination"
                          : "",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
          
              /// DEPARTURE TIME
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    !isLast
                        ? Text(
                            dateTimeData.minToTime(stop.deptTime),
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontSize: 12,
                                  letterSpacing: 0.1,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                          )
                        : Text(
                            "End",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
          
                    if (!isLast)
                      Text(
                        "departure",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}