import 'package:flutter/material.dart';


import 'package:planner_demo/widgets/more%20options/settings/app%20theme/find_route_button_demo.dart';
import 'package:planner_demo/widgets/more%20options/settings/app%20theme/location_details_selection_block_demo.dart';
import 'package:planner_demo/widgets/more%20options/settings/app%20theme/main_title_demo.dart';

class PreviewBlockDemoScreen extends StatelessWidget{
  const PreviewBlockDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1
        )
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: MainTitleDemo(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16,),
            child: LocationDetailsSelectionBlockDemo(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 16, top:4),
            child: FindOptimalRouteButtonDemo(),
          ),

          SizedBox(height: 16,),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
            // Translucent Floating Navigation Bar Pill
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _navItem(context,Icons.home, "Home", true)),
                  Expanded(child: _navItem(context,Icons.location_pin, "Stops", false)),
                  Expanded(child: _navItem(context,Icons.save, "Trips", false)),
                  Expanded(child: _navItem(context,Icons.more_horiz, "More", false)),
                ],
              ),
            ),
                    ),
          ),

        ],
      ),
    );
  }
}
Widget _navItem(BuildContext context, icon, String label, bool isSelected) {

    Color activeColor = Theme.of(context).colorScheme.primary;
    Color inactiveColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withAlpha(50) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? activeColor : inactiveColor,
                size: 12,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 8,
                  color: isSelected ? activeColor : inactiveColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

