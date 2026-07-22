import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/logic/save_trips.dart';
import 'package:planner_demo/logic/trip_id_generator.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/screens/trip_navigation_screen.dart';

class SavedConnectionsBlock extends ConsumerWidget {
  const SavedConnectionsBlock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Result> savedTrips = ref.watch(savedTripsProvider);

    final theme = Theme.of(context);

    if (savedTrips.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 48),
        child: Center(
          child: Text(
            "No saved trips yet",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: savedTrips.length,
      itemBuilder: (context, index) {
        final Result trip = savedTrips[index];

        return Dismissible(
          key: ValueKey(generateTripId(trip)),
          direction: DismissDirection.endToStart,
          background: Container(),
          secondaryBackground: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Icon(
              Icons.delete_rounded,
              color: Theme.of(context).colorScheme.onErrorContainer,
              size: 28,
            ),
          ),

          // 1. Only confirm the action here without mutating your state
          confirmDismiss: (_) async => true,

          // 2. Perform the state mutation and show the SnackBar here
          onDismissed: (direction) async {
            // Remove from SQLite + Provider safely after animation completes
            await deleteTrip(ref, trip);

            if (context.mounted) {
              ScaffoldMessenger.of(context).clearSnackBars();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,

                  elevation: 0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  duration: const Duration(seconds: 4),
                  persist:
                      false, // <-- FIX: Force auto-dismiss despite having an action button
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHigh,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(32),
                  ),
                  content: Text(
                    "Trip removed",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () async {
                      await saveTrip(ref, trip);
                    },
                  ),
                ),
              );
            }
          },

          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: Theme.of(context).colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(color: Theme.of(context).dividerColor),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: Icon(
                  Icons.bookmark_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  "${trip.path.first.placeName} → ${trip.path.last.placeName}",
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(fontSize: 13),
                ),
                subtitle: Text("${trip.path.length - 1} Stop(s)"),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TripNavigationScreen(results: trip),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
