import 'package:flutter/material.dart';

class SavedTripsTitleCard extends StatelessWidget {
  const SavedTripsTitleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 46),
            Row(
              children: [
                Text(
                  "SAVED ",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "TRIPS",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                  ),
                ),
              ],
            ),

            SizedBox(height: 2),

            Text(
              "SYSTEM OPTIMIZED",
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: Colors.black54),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
