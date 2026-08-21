import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/models/app_data.dart';
import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/widgets/route results/circular_coloured_icon.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ScheduleTripCardTimeline extends ConsumerWidget {
  const ScheduleTripCardTimeline({
    super.key,
    required this.results,
    required this.selectedtime,
  });

  final Result? results;
  final String selectedtime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trip = results?.path ?? [];
    final DateTimeData dateTimeData = DateTimeData();
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    if (trip.isEmpty) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 20),
          Text("No route found!!"),
          SizedBox(height: 80),
        ],
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: trip.length,
      itemBuilder: (context, index) {
        final stop = trip[index];
        final bool isFirst = index == 0;
        final bool isLast = index == trip.length - 1;

        final LineStyle timelineLineStyle = LineStyle(
          color: Theme.of(context).dividerColor,
          thickness: 2,
        );

        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.32,

          isFirst: isFirst,
          isLast: isLast,
          beforeLineStyle: timelineLineStyle,
          afterLineStyle: timelineLineStyle,
          indicatorStyle: IndicatorStyle(
            width: 22,
            height: 22,
            indicator: isFirst
                ? CircularColouredIcon(
                    iconData: Icons.directions_walk,
                    color: Colors.green,
                  )
                : !isLast
                ? CircularColouredIcon(
                    iconData: Icons.directions_bus,
                    color: Theme.of(context).dividerColor,
                    isfillColor: false,
                  )
                : CircularColouredIcon(
                    iconData: Icons.flag,
                    color: scheme.primary,
                  ),
          ),
          startChild: Padding(
            padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isFirst) const SizedBox(height: 6),
                Text(
                  !isFirst ? dateTimeData.minToTime(stop.arrivalTime) : "Start",
                  style: textTheme.titleSmall?.copyWith(
                    fontSize: isFirst ? 14 : 10,
                    letterSpacing: 0.1,
                    color: isFirst ? Colors.green : null,
                  ),
                ),
                Text(
                  !isFirst ? "arrival" : "",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isFirst) const SizedBox(height: 8),
                Text(
                  stop.placeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headlineSmall?.copyWith(
                    fontSize: (isFirst || isLast) ? 14 : 12,
                  ),
                ),
                if (!isLast) ...[
                  Text(
                    dateTimeData.minToTime(stop.deptTime),
                    style: textTheme.titleSmall?.copyWith(
                      fontSize: 10,
                      letterSpacing: 0.1,
                    ),
                  ),
                ] else
                  Text(
                    "End",
                    style: textTheme.headlineSmall?.copyWith(
                      fontSize: 14,
                      color: scheme.primary,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
