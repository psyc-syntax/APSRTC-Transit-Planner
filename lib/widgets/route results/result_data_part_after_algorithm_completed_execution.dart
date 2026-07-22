import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/models/date_data.dart';


import 'package:planner_demo/widgets/route%20results/route_result_trip_card.dart';
import 'package:planner_demo/widgets/route%20results/route_results_location_details.dart';
import 'package:planner_demo/widgets/shared/top_title.dart';
import 'package:planner_demo/widgets/route%20results/route_results_trip_params.dart';
import 'package:planner_demo/widgets/route%20results/start_trip_button.dart';
import 'package:planner_demo/widgets/route%20results/strat_time_details_block.dart';

class RouteResultsDataPart extends ConsumerWidget {
  const RouteResultsDataPart({super.key, required this.results});

  final Result results;



  @override
  Widget build(BuildContext context, ref) {

    DateTimeData dateTimeData = DateTimeData();

 if(results.path.isNotEmpty){
   print(
    "RouteResultsDataPart rebuilt: "
    "first departure = ${results.path.first.deptTime}, "
    "destination arrival = ${results.path.last.arrivalTime}",
  );
 }

    
    


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBody: true,
      floatingActionButton: results.path.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 16,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: StartTripButton(results: results,),
              ),
            )
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TopTitle(isbackNeeded: true, title: ""),

              const SizedBox(height: 16),

              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      RouteResultsLocationDetails(),
                      const SizedBox(height: 6),
                
                if (results.path.isNotEmpty && results.path.length > 1)
                  RouteResultsTripParams(results: results),
                
                if (results.path.isNotEmpty && results.path.length > 1)
                const SizedBox(height: 6),
                
                if (results.path.isNotEmpty && results.path.length > 1)
                  StratTimeDetailsBlock(
                    startTime: results.path[0].deptTime.toString(),
                    startTimeMin: results.path[0].deptTime,
                  ),
                
                
                RouteResultTripCard(
                  results: results, 
                  selectedtime: (dateTimeData.timeToMin(DateTime.now())).toString(),
                  ),

                  SizedBox(height: 200,)
                    ],
                  )
                ),
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}