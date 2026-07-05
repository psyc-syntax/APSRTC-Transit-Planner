import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/trips/trip_card.dart';
import 'package:planner_demo/widgets/trips/trips_type_bar.dart';

class SavedConnectionsBlock extends StatelessWidget {
  const SavedConnectionsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(height: 8,),

          TripsTypeBar(),
          
          // SizedBox(height: 25,),

          // TripCard(),
          // SizedBox(height: 10,),
          // TripCard(),
          // SizedBox(height: 10,),
          // TripCard(),
          // SizedBox(height: 10,),
          // TripCard(),
          // SizedBox(height: 10,),
          // TripCard(),
          // SizedBox(height: 10,),
          // TripCard(),
          // SizedBox(height: 10,),
          // TripCard(),

          

        ],
      ),
    );
  }
}
