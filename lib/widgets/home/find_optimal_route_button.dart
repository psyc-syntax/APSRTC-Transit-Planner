import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/screens/route_results_screen.dart';

class FindOptimalRouteButton extends ConsumerWidget{
  const FindOptimalRouteButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bool isstartingPlaceSelected = ref.watch(isstartingPlaceSelectedProvider);
    final bool isdestinationPlaceSelected = ref.watch(isdestinationPlaceSelectedProvider);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlpha(75),
            blurRadius: 16.0,
            offset: Offset(0, 8),
          )
        ]
      ),
      child: ElevatedButton(
        onPressed: (){
          // if(isstartingPlaceSelected && isdestinationPlaceSelected){
          //   ref.read(runAlgorithmTriggerProvider.notifier).state++;
          //   Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (ctx) => RouteResultsScreen()) 
          // );
          // }

          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => RouteResultsScreen())
          );
        }, 
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("PLAN SMART TRIP", style: TextStyle(fontSize: 16),),
              Icon(Icons.bolt, size: 18,),
            ],
          ),
        ),
      ),
    );
  }
}