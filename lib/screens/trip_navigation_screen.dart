import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:planner_demo/logic/save_trips.dart';

import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/widgets/trip%20navigation/detailed_trip_details.dart';
import 'package:planner_demo/widgets/trip%20navigation/location_details_block.dart';
import 'package:planner_demo/widgets/trip%20navigation/location_params.dart';
import 'package:planner_demo/widgets/shared/top_title.dart';

import '../models/app_data.dart';

class TripNavigationScreen extends ConsumerWidget {
  const TripNavigationScreen({super.key, required this.results});

  final Result results;

  @override
  Widget build(BuildContext context, ref) {
    // Dynamically fetch the background color so it works flawlessly in both Light and Dark mode
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;

    final saved = isTripSaved(ref, results);

    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: Main App Layout & Timeline Scroll
          SafeArea(
            bottom: false,
            top: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TopTitle(isbackNeeded: true, title: "More Details"),
                      GestureDetector(
                        
                       child:  Icon(
                          saved ? Icons.bookmark : Icons.bookmark_border,
                          size: 32,
                        ),

                        onTap: () async {
                          if (saved) {
                            await deleteTrip(ref, results);
                          } else {
                            await saveTrip(ref, results);
                          }
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          TripNavLocationDetails(results: results),
                          SizedBox(height: 6),
                          TripNavLocationParams(results: results),

                          const SizedBox(height: 6),

                          Column(
                            children: [
                              TripNavDetailedTripDetails(results: results),
                              SizedBox(height: 100),
                              SizedBox(height: 50),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Layer 2: Telegram-Style Bottom Scrim Gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height:
                100, // Height covers the floating card background buffer area perfectly
            child: IgnorePointer(
              // CRITICAL: IgnorePointer ensures users can still scroll or click elements through the gradient overlay
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      bgColor.withOpacity(0.0), // Starts fully transparent
                      bgColor.withOpacity(0.8), // Smooth transition buildup
                      bgColor, // Ends completely solid at the device edge
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
