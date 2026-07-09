

import 'package:flutter/material.dart';

class DatabaseSizeBlock extends StatelessWidget{
  const DatabaseSizeBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border.all(
          color: Theme.of(context).dividerColor
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(Icons.dns, color: Theme.of(context).dividerColor,),
            SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Database Size", style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: 4,),
                Text("52.8 MB", style: Theme.of(context).textTheme.titleMedium,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}