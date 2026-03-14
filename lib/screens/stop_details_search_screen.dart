
import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/main%20stop%20search/stop_detiails_search_title.dart';
import 'package:planner_demo/widgets/stop%20seraching/popular/nearby_stops_block.dart';


class StopDetailsSearchScreen extends StatefulWidget{
  const StopDetailsSearchScreen({super.key});

  @override
  State<StopDetailsSearchScreen> createState() {
   return _StopSearchScreen();
  }
}

class _StopSearchScreen extends State<StopDetailsSearchScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32)
              )
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 46,),
          
                  //main title
                  StopDetailsSearchTitle(),
          
                  //text field
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color : Colors.black54,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search, 
                          color: Theme.of(context).colorScheme.primary, 
                          size: 32,
                        ),
                        hintText: "SELECT STOP",
                        filled: true,
                        fillColor: const Color.fromARGB(96, 211, 225, 250),
                        hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black54,
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey)
                        ),
                    
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          )
                        ), 
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      NearbyStopsBlock(),
                    ],
                  ),
                )
              ),
            ),
          ),

        ],
      ),
    );
  }
}