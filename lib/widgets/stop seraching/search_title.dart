import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/shared/button_with_icon.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //return button
        ButtonWithIcon(icon: Icons.arrow_back),

        //gap between title and return button
        SizedBox(width: 16),

        //title and subtitle
        Column(
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
        ),
      ],
    );
  }
}
