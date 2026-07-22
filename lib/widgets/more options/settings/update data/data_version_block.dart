import 'package:flutter/material.dart';

class DataVersionBlock extends StatelessWidget{
  const DataVersionBlock({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).dividerColor
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current Data version",
             style: Theme.of(context).textTheme.titleLarge
            ),
        
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("0.0.0.1", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 32,
                        
                      ),),

                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withAlpha(50),
                    borderRadius: BorderRadius.circular(32)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Up to Date", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 10
                    ),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}