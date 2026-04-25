import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/saved%20trips/saved_connections_block.dart';
import 'package:planner_demo/widgets/saved%20trips/saved_trips_title_card.dart';

class SavedTripsScreen extends StatelessWidget {
  const SavedTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top : true,
        left : true,
        right : true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SavedTripsTitleCard(),
            Expanded(
              child: SingleChildScrollView(
                child: SavedConnectionsBlock(),
              ),
            )
          ],
        ),
      )
    );
  }
}
