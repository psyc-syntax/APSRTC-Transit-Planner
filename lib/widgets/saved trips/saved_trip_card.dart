import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/shared/glowing_dot.dart';

class SavedTripCard extends StatelessWidget{
  const SavedTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: BoxBorder.all(
            color: Theme.of(context).dividerColor,
            width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor,
            blurRadius:2.0,
            spreadRadius: 1.0,
            offset: Offset(0, 0),
          ),
        ]
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GlowingDot(dotColor: Theme.of(context).colorScheme.primary),
                      SizedBox(width: 8,),
                      Text(
                      "KAKINADA",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 18,
                      ),
                      )
                    ],
                  ),
      
                  Icon(Icons.arrow_right_alt_rounded),
      
                  Row(
                    children: [
                      Text(
                      "VIJAYAWADA",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 18,
                        ),
                      ),
      
                      SizedBox(width: 8,),
      
                      Icon(
                        Icons.circle, 
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 12,
                      ),
      
                    ],
                  )
                ],
              ),
            ),
      
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("FREQUENCY",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),),
                  Text("4h 10m \$340", 
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}