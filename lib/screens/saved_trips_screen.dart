import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/saved%20trips/saved_connections_block.dart';
import 'package:planner_demo/widgets/saved%20trips/saved_trips_title_card.dart';

class SavedTripsScreen extends StatelessWidget {
  const SavedTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SavedTripsTitleCard(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: SingleChildScrollView(
                child: SavedConnectionsBlock(),
              ),
            ),
          )
        ],
      )
    );
  }
}
