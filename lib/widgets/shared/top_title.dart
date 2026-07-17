import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget{
  const TopTitle({super.key, required this.isbackNeeded, required this.title});

  final bool isbackNeeded;
  final String title;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
                children: [
                  if(isbackNeeded) GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 24,
                    ),
                  ),

                  SizedBox(width: 16),
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
                  ),

                  
                ],
              );
  }
}