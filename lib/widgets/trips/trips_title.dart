import 'package:flutter/material.dart';

class TripsTitle extends StatelessWidget {
  const TripsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Trips",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.add, size: 32,),
          ),
        )
    
      ]
    );      
}
}