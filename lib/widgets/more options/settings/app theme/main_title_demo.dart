import 'package:flutter/material.dart';


class MainTitleDemo extends StatelessWidget {
  const MainTitleDemo({super.key});

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
              Card(
                elevation: 4,
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    Icons.navigation_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 14,
                  ),
                ),
              ),

              // gap between app title and icon
              SizedBox(width: 3),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mark", // main app title
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(height: 0.9, fontSize: 16),
                  ),
                  Text(
                    'Transit Intelligence', // app subtitle
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
