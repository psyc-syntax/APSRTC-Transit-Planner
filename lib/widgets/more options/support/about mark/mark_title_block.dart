import 'package:flutter/material.dart';

class MarkTitleBlock extends StatelessWidget{
  const MarkTitleBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("MARK", style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color:  Theme.of(context).colorScheme.primary,
          fontSize: 62,
          height: 0.8
        ),),

        Text("Plan Your Journey", style: Theme.of(context).textTheme.titleLarge,)
      ],
    );
  }
}