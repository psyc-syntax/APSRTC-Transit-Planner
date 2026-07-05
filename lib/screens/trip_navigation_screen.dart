import 'package:flutter/material.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/widgets/trip%20navigation/detailed_trip_details.dart';
import 'package:planner_demo/widgets/trip%20navigation/location_details_block.dart';
import 'package:planner_demo/widgets/trip%20navigation/location_params.dart';

class TripNavigationScreen extends StatelessWidget {
  const TripNavigationScreen({
    super.key,
    required this.results,
  });

  final Result results;

  @override
  Widget build(BuildContext context) {
    // Dynamically fetch the background color so it works flawlessly in both Light and Dark mode
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      
      
      body: Stack(
        children: [
          // Layer 1: Main App Layout & Timeline Scroll
          SafeArea(
            bottom: false,
            top: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),

                  const SizedBox(height: 6),
            
                  TripNavLocationDetails(results: results),
                  SizedBox(height: 6,),
                  TripNavLocationParams(results: results),

                  const SizedBox(height: 10),


                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TripNavDetailedTripDetails(results: results),
                          SizedBox(height: 100,),
                          SizedBox(height: 50,)
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
            height: 100, // Height covers the floating card background buffer area perfectly
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
                      bgColor,                  // Ends completely solid at the device edge
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