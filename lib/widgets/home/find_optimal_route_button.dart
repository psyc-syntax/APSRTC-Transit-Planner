import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:planner_demo/screens/route_results_screen.dart';

class FindOptimalRouteButton extends StatelessWidget{
  const FindOptimalRouteButton({super.key});

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("FIND OPTIMAL ROUTE", style: TextStyle(fontSize: 18),),
              Icon(Icons.bolt, size: 24,),
            ],
          ),
        ),
      ),
    );
  }
}