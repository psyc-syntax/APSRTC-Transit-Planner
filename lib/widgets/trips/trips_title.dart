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
        
        
    
      ]
    );      
}
}