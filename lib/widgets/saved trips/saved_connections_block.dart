import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/saved%20trips/saved_trip_card.dart';

class SavedConnectionsBlock extends StatelessWidget {
  const SavedConnectionsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bolt_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                "SAVED CONNECTIONS",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall,
              ),
            ],
          ),
          SizedBox(height: 10,),

          SavedTripCard(),
          SavedTripCard(),
          SavedTripCard(),
          SavedTripCard(),
          SavedTripCard(),
          SavedTripCard(),
          SavedTripCard(),

          

        ],
      ),
    );
  }
}
