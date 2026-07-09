import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';


class LocationDetailsSelectionBlockDemo extends ConsumerWidget {
  const LocationDetailsSelectionBlockDemo({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final startingPlaceName = ref.watch(startingPlaceNameProvider);
    final destinationPlaceName = ref.watch(destinationPlaceNameProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       
        //right side maincontent
        

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
              borderRadius:  BorderRadius.circular(32)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "From",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(
                      height: 0.9,
                      fontSize: 12
                      ),
                  ),
                  SizedBox(height: 2),
            
                  Text(
                    startingPlaceName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 12,
                      letterSpacing: 0,
                    ),
                  ),
            
                  SizedBox(height: 4),
            
                  //horizontal line
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
            
                  SizedBox(height: 4),
            
                  Text(
                    "To",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(height: 0.9,fontSize: 12),
                  ),
            
                  SizedBox(height: 2),
            
                  Text(
                    destinationPlaceName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 12,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
