import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/trips/saved_connections_block.dart';
import 'package:planner_demo/widgets/trips/trips_title.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top : true,
        left : true,
        right : true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TripsTitle(),
              Expanded(
                child: SingleChildScrollView(
                  child: const SavedConnectionsBlock(),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
