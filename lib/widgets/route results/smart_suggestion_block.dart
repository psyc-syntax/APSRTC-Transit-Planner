import 'package:flutter/material.dart';

class SmartSuggestionBlock extends StatelessWidget{
  const SmartSuggestionBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 50,),
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
                    Icon(Icons.auto_awesome, color: Colors.orange.withAlpha(150),),
                    SizedBox(width: 2,),
                    Text("No suitable journey found", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                    ),)
                  ],
                ),
            
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Text("Try changing your departure time or selecting a nearby stop or location. A small change in your search may help us find more journey options for you.",
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