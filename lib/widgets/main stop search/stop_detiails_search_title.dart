import 'package:flutter/material.dart';

class StopDetailsSearchTitle extends StatelessWidget {
  const StopDetailsSearchTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SELECT STOP",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.black),
            ),

            Text(
              "DIJKSTRA NODE SELECTION",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        );
  }
}
