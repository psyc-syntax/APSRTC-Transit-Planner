

import 'package:flutter/material.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/widgets/route%20results/circular_coloured_icon.dart';
import 'package:planner_demo/widgets/trip%20navigation/timeline/transit_endchild_card.dart';
import 'package:planner_demo/widgets/trip%20navigation/timeline/waiting_time_endchild_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TripNavDetailedTripDetails extends StatelessWidget {
  const TripNavDetailedTripDetails({super.key, required this.results});

  final Result results;

  

  @override
  Widget build(BuildContext context) {

    final DateTimeData dateTimeData = DateTimeData();
    
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final trip = results.path;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: results.path.length,
      itemBuilder: (context, index) {
        final stop = results.path[index];

        final bool isFirst = index == 0;
        final bool isLast = index == trip.length - 1;
        final bool hasWaitTime = stop.arrivalTime != stop.deptTime && !isLast;
       
        int waitingTime = dateTimeData.waitingTimeFinder(stop.arrivalTime, stop.deptTime);
        
        

        final LineStyle currentLineStyle = LineStyle(color: Theme.of(context).disabledColor.withOpacity(0.2), thickness: 2.5);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              // ----------------------------------------------------
              // 1. MAIN STATION NODE
              // ----------------------------------------------------
              TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.22,
                isFirst: isFirst,
                isLast: isLast && !hasWaitTime,
                beforeLineStyle: currentLineStyle,
                afterLineStyle: currentLineStyle,
                indicatorStyle: IndicatorStyle(
                  width: 24,
                  height: 24,
                  indicator: _buildIndicatorDot(
                    context,
                    isFirst: isFirst,
                    isLast: isLast,
                  ),
                ),
                startChild: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    dateTimeData.minToTime(
                      isFirst ? stop.deptTime : stop.arrivalTime,
                    ),
                    textAlign: TextAlign.right,
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 12,
                      
                      color: isFirst 
                          ? Colors.green
                          : (isLast ? Theme.of(context).colorScheme.primary : scheme.onSurface),
                    ),
                  ),
                ),
                endChild: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 12, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isFirst)
                        Text(
                          "START",
                          style: textTheme.labelSmall?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      if (isLast)
                        Text(
                          "DESTINATION",
                          style: textTheme.labelSmall?.copyWith(
                            color: scheme.error,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      Text(
                        stop.placeName,
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 14
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ----------------------------------------------------
              // 2. LAYOVER / WAITING TIME ELEMENT
              // ----------------------------------------------------
              if (hasWaitTime && !isFirst) ...[
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.22,
                  isFirst: false,
                  isLast: false,
                  beforeLineStyle: currentLineStyle,
                  afterLineStyle: currentLineStyle,
                  indicatorStyle: IndicatorStyle(
                    width: 20,
                    height: 20,
                    // indicator: Container(
                    //   decoration: BoxDecoration(
                    //     color: scheme.surfaceContainerHigh,
                    //     shape: BoxShape.circle,
                    //     border: Border.all(color: scheme.primary, width: 2),
                    //   ),
                    //   child: Icon(Icons.access_time_filled, size: 12, color: scheme.primary),
                    // ),

                    indicator: CircularColouredIcon(
                      iconData: Icons.access_time_filled, 
                      color: const Color.fromARGB(255, 255, 203, 31),
                      )
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 6, bottom: 6),
                    child: WaitingTimeEndchild(
                      duration: waitingTime
                    )
                  ),
                ),
                
                // Departure tracking node following a layover
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.22,
                  isFirst: false,
                  isLast: isLast,
                  beforeLineStyle: currentLineStyle,
                  afterLineStyle: currentLineStyle,
                  indicatorStyle: IndicatorStyle(
                    width: 16,
                    height: 16,
                    indicator: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: scheme.outline, width: 2.5),
                      ),
                    ),
                  ),
                  startChild: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      dateTimeData.minToTime(stop.deptTime),
                      textAlign: TextAlign.right,
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 12, bottom: 12),
                    child: Text(
                      "${stop.placeName} (Departure)",
                      style: textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],

              // ----------------------------------------------------
              // 3. TRANSIT LEG VEHICLE CARD
              // ----------------------------------------------------
              if (!isLast)
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.22,
                  isFirst: false,
                  isLast: false,
                  beforeLineStyle: currentLineStyle,
                  afterLineStyle: currentLineStyle,
                  indicatorStyle: IndicatorStyle(
                    width: 24,
                    height: 24,
                    indicator: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).dividerColor
                        )
                      ),

                    
                      child: Icon(
                        Icons.directions_bus_rounded,
                        size: 16 ,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
                    child: TransitEndchildCard(
                      title: "Ultra Deluxe", 
                      subtitle: "Service No: 1234",
                      timeString: "Dept: ${dateTimeData.minToTime(stop.deptTime)}",
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // ===========================================================================
  // SUB-WIDGET UTILITY METHODS
  // ===========================================================================

  Widget _buildIndicatorDot(BuildContext context, {required bool isFirst, required bool isLast}) {
    final scheme = Theme.of(context).colorScheme;
    Color dotColor = Theme.of(context).dividerColor;
    IconData? nodeIcon;

    if (isFirst) {
      dotColor = Colors.green;
      nodeIcon = Icons.directions_walk;
    } else if (isLast) {
      dotColor = Theme.of(context).colorScheme.primary;
      nodeIcon = Icons.flag_rounded;
    }

    return Container(
      decoration: BoxDecoration(
        color: nodeIcon != null ? dotColor : scheme.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: nodeIcon == null ? scheme.onSurfaceVariant : dotColor,
          width: nodeIcon != null ? 0 : 3,
        ),
      ),
      child: nodeIcon != null 
          ? Icon(nodeIcon, size: 14, color: scheme.onPrimary) 
          : const SizedBox.shrink(),
    );
  }

  

  
}