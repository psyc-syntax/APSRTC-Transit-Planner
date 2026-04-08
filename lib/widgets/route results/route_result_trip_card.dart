import 'package:flutter/material.dart';

class RouteResultTripCard extends StatelessWidget {
  const RouteResultTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            spreadRadius: 2.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        
        children: [
          Text("kumar"),
        ],
      )
    );
  }
}
