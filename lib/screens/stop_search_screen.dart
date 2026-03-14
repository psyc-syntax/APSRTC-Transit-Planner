
import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/stop%20seraching/popular/nearby_stops_block.dart';
import '../widgets/stop seraching/search_title.dart';

class StopSearchScreen extends StatefulWidget{
  const StopSearchScreen({super.key});

  @override
  State<StopSearchScreen> createState() {
   return _StopSearchScreen();
  }
}

class _StopSearchScreen extends State<StopSearchScreen>{
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 36,),
          
                  //main title
                  MainTitle(),
          
                  //text field
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 36),
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
                        hintText: "Where are you starting?",
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