

import 'package:flutter/material.dart';

class NoteSuggestionBlock extends StatelessWidget{
  const NoteSuggestionBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
  
        Container(
          decoration: BoxDecoration(

           
            border: Border.all(
              color: Theme.of(context).dividerColor
            ),
            borderRadius: BorderRadius.circular(32)
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.light, color: Colors.orange.withAlpha(150),),
                    SizedBox(width: 2,),
                    Text("Note", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                    ),)
                  ],
                ),
            
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Text("Schedules are based on available timetable data. Verify before travel.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}