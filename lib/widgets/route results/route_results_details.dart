import 'package:flutter/material.dart';

class RouteResultsDetails extends StatelessWidget {
  const RouteResultsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            //left part with icons and vertical line
            Column(
              children: [

                SizedBox(height: 4,),
                //from Icon
                Icon(
                  Icons.radio_button_on,
                  color: Theme.of(context).colorScheme.primary,
                  size: 14,
                ),
    
                //vertical line
                Container(width: 2, height: 26, color: const Color(0xFFE2E8F0)),
    
                //too Icon
                Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
              ],
            ),
    
            SizedBox(width: 14),
    
            //right part with location names and horizontal line
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    "Bangalore City",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                  SizedBox(height: 8),
                  
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: double.infinity, 
                      height: 2, 
                      color: const Color(0xFFE2E8F0)
                    ),
                  ),
                  
                  SizedBox(height: 8),  
                  Text(
                    "Bangalore International Airport",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
