
import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/home/find_optimal_route_button.dart';
import 'package:planner_demo/widgets/home/app_logo_text.dart';
import 'package:planner_demo/widgets/home/route_search_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Container(

        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          
          top: true,
          bottom: false,
          left: true,
          right: true,
        
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //top title(offline engine ready, database info)
              // TopTitle(),
              // HorizontalLine(),
        
              //main title (app icon and dropdown menu)
              MainTitle(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: RouteSearchCard(), //trip details selection card
                      ),
        
                      // optimal route button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 12,
                        ),
                  
                        // find optimal route button
                        child: FindOptimalRouteButton(),
                      ),

                     
        
                      // recent history section
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     left: 16,
                      //     right: 16,
                      //     top : 16,
                      //   ),
                      //   // child: QuickHistory(),
                      //   child: OnGoingTripBlock(),
                      // ),


                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     left: 16,
                      //     right: 16,
                      //     top : 16,
                      //   ),
                      //   // child: QuickHistory(),
                      //   child: OnGoingTripBlock(),
                      // ),
        
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
