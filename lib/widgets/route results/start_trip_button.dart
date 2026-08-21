import 'package:flutter/material.dart';

import 'package:planner_demo/screens/trip_navigation_screen.dart';

import '../../models/app_data.dart';

class StartTripButton extends StatelessWidget{
  const StartTripButton(
    {
      super.key,
      required this.results
    }
    );

  final Result results;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        
      ),
      child: ElevatedButton(
        onPressed: (){
          Navigator.of(context).push(
          MaterialPageRoute(builder: (context){
            return TripNavigationScreen(results: results,);
          })
        );
        },
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(32),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("More Details", style: TextStyle(fontSize: 16)),
              SizedBox(width: 2,),
              Icon(Icons.catching_pokemon, size: 18),
            ],
          ),
        )
      ),
    );
  }
}