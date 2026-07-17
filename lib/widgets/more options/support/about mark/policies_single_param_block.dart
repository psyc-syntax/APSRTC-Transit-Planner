import 'package:flutter/material.dart';

class PoliciesSingleParamBlock extends StatelessWidget{
  const PoliciesSingleParamBlock({super.key , required this.icon, required this.detail});

  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        border: Border.all(
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(32),
      ),

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
            SizedBox(width: 10,),
            Text(detail, style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant
            ),),
          ],
        ),
      ),
    );
  }
}