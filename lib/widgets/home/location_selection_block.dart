import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/screens/stop_search_screen.dart';

class LocationSelectionBlock extends ConsumerWidget{
  const LocationSelectionBlock({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final startingPlaceName = ref.watch(startingPlaceNameProvider);
    final destinationPlaceName = ref.watch(destinationPlaceNameProvider);
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //left side icons
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 12, top: 16),
            child: Column(
              children: [
                //from Icon
                Icon(Icons.radio_button_on,
                color: Theme.of(context).colorScheme.primary,
                size: 14,
                ),
            
                //vertical line
                Container(
                  width: 2,
                  height: 50,
                  color: const Color(0xFFE2E8F0),
                ),
            
                //too Icon
                Icon(Icons.location_on_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
                ),
              ],
            ),
          ),


          //right side maincontent
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("FROM",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.black54,
                    letterSpacing: 0,
                  ),
                  ),
                  SizedBox(height: 4,),
              
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => StopSearchScreen(isbackneeded: true, isStartingStop: true,),
                        ),
                      );
                    },
                    child: Text(startingPlaceName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 16,
                        color: Colors.black54,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
              
                  SizedBox(height: 8,),
                  
                  //horizontal line
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: const Color(0xFFE2E8F0),
                    ),
                  ),
              
                  SizedBox(height: 8,),
              
                  Text("TO",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.black54,
                    letterSpacing: 0,
                    
                  ),
                  ),
              
                  SizedBox(height: 4,),
              
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => StopSearchScreen(
                            isbackneeded: true,
                            isStartingStop: false,
                          )
                        )
                      );
                    },
                    child: Text(destinationPlaceName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 16,
                      color: Colors.black54,
                      letterSpacing: 0,
                    ),
                    ),
                  ),
              
                ],
              ),
            ),
          )
        ],
      );
  }
}