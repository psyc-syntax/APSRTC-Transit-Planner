import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/shared/app_icon.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //main app Icon
              // AppIcon(),

              // gap between app title and icon
              SizedBox(width: 6),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MarkBus", // main app title
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      height: 0.9,
                    ),
                  ),
                  Text(
                    'MARK YOUR BUS', // app subtitle
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Drop Down menu button
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Icon(Icons.menu, size: 30),
          // ),
        ],
      ),
    );
  }
}
