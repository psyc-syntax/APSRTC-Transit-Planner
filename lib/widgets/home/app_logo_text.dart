import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/shared/app_icon.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //main app Icon
              AppIcon(),

              // gap between app title and icon
              SizedBox(width: 8,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "APSRTC", // main app title 
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "TRANSIT INTELLIGENCE", // sub title 
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),

          // Drop Down menu button
          Icon(Icons.menu,
          size: 30,),
        ],
      ),
    );
  }
}
