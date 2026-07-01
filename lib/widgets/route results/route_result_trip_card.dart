import 'package:flutter/material.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/widgets/route%20results/circular_coloured_icon.dart';

class RouteResultTripCard extends StatelessWidget {
  const RouteResultTripCard({super.key, required this.results});

  final Result? results;

  @override
  Widget build(BuildContext context) {
    final trip = results?.path ?? [];

    String minToTime(int minutes) {
      minutes %= 1440;

      int hours = minutes ~/ 60;
      int min = minutes % 60;

      final String period = hours >= 12 ? "PM" : "AM";

      hours = hours % 12;

      return "${hours.toString().padLeft(2, '0')}:"
          "${min.toString().padLeft(2, '0')} $period";
    }

    if (trip.isEmpty) {
      return const Center(child: Text("No Route Found"));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: trip.length,
      itemBuilder: (context, index) {
        final stop = trip[index];

        final bool isFirst = index == 0;
        final bool isLast = index == trip.length - 1;

        return Row(
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
                          "${minToTime(stop.arrivalTime)}",
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
                          "${minToTime(stop.deptTime)}",
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
        );
      },
    );
  }
}
