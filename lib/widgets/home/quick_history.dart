import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/home/quick_history_trip_card.dart';

class QuickHistory extends StatelessWidget {
  const QuickHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 1. The Title Row (Icon + Text)
        Row(
          children: [
            const Icon(Icons.history, size: 16,),
            const SizedBox(width: 8),
            Text(
              "QUICK HISTORY",
              style: Theme.of(context).textTheme.titleSmall
            ),
          ],
        ),

        SizedBox(height: 10,),

        // The List of Cards
        ListView.builder(
          itemCount: 4,           
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),     
          itemBuilder: (context, index) {
            return const QuickHistoryTripCard();
          },
        ),
      ],
    );
  }
}