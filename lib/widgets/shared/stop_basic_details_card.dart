import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/shared/button_with_icon.dart';

class StopBasicDetailsCard extends StatelessWidget{
  const StopBasicDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Row(
              children: [
                ButtonWithIcon(
                  icon: Icons.business, 
                  elevation: 0.1,
                  iconsize: 42, 
                  fillColor: Theme.of(context).colorScheme.surface,
                  iconColor: Theme.of(context).dividerColor,
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("STOP NAME", 
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 18,
                    ),
                  ),
          
                  Text(
                    "PANCHAYAT",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      letterSpacing: 0,
                    ),
                  ),
          
                  Row(
                    children: [
                      Text("DISTRICT - ", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      letterSpacing: 0,
                    ),
                    ),
                      Text("PINCODE", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      letterSpacing: 0,
                    ),
                      ),
                    ],
                  ),
                  
                  ],
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
               height: 2,
               width: double.infinity,
               color: Theme.of(context).dividerColor,
             )
        ],
      ),
    );
  }
}