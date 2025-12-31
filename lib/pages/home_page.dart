import 'package:flutter/material.dart';
import 'package:planner_demo/utils/finding_best_route_button.dart';
import 'package:planner_demo/utils/optimization_slection.dart';
import 'package:planner_demo/utils/travel_date_selection.dart';
import 'package:planner_demo/utils/trip_datails.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "Plan Your Journey",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22,
              ),
              ),
            const SizedBox(height: 5),
            Text(
              "APSRTC Real-time Router",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            //trip details selection block
            Stack(
              children: [
                Container(
                  height: 40,
                  color: Colors.blue[900],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
                  child: TripDatails(),
                ),
              ],
            ),
            //gap between
            SizedBox(height: 20),
        
            //travel date selection
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TravelDateSelection(),
            ),
        
            //gap between them
            SizedBox(height : 20),
            Padding(
              padding: const EdgeInsets.only(left : 30.0, right: 30),
              child: OptimizationSlection(),
            ),
        
            //gap between block
            SizedBox(height: 40,),
            //finding best route button
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: FindingBestRouteButton(),
            ),
            
          ],
        ),
      ),



    );
  }
}