import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/shared/button_with_icon.dart';

class RouteResultsTitle extends StatelessWidget {
  const RouteResultsTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonWithIcon(icon: Icons.arrow_back),
        
        SizedBox(width: 16),
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ROUTE RESULTS",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall,
            ),

            Text(
              "MARK PATH SELECTION",
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
