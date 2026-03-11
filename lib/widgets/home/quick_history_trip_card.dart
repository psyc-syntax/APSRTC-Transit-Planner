import 'package:flutter/material.dart';

class QuickHistoryTripCard extends StatelessWidget {
  const QuickHistoryTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Card(
                elevation: 0,
                color: Theme.of(context).dividerColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    Icons.navigation_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 20,
                  ),
                ),
              ),
      
              SizedBox(width: 10,),
              
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //from - to (trip details)
                  "Kakinada - Rajahmundry", 
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 16,
                  ),
                ),
              
                Text(
                  //trip searched date which is mentioned
                  "Yesterday",
                  style: Theme.of(context).textTheme.titleSmall,
                )
              
              ],
            )
            ],
          ),
        ),
      ),
    );
  }
}
