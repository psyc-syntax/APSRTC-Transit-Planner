import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget{
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
          size: 28,),
      ), 
    );
  }
}