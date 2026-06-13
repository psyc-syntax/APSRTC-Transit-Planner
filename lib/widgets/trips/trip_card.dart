import 'package:flutter/material.dart';


class TripCard extends StatelessWidget{
  const TripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: BoxBorder.all(
          color: Theme.of(context).dividerColor,
          width: 1,
      ),
      borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    
                    Text(
                    "Kakinada",
                    style: Theme.of(context).textTheme.titleLarge
                    ),
                    SizedBox(width: 10,),
            
                    Icon(Icons.arrow_right_alt_rounded),
                    SizedBox(width: 10,),
            
                    Text(
                    "Vijayawada",
                    style: Theme.of(context).textTheme.titleLarge
                    ),
            
                  ],
                ),
                  
              ]
            ),

            const SizedBox(height: 6,),



            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month, 
                      size: 15, 
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),

                    SizedBox(width: 3,),
                    Text("25 may 2026",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      letterSpacing: 0.1,
                    ),
                    )
                  ],
                ),

                SizedBox(width: 15,),

                Row(
                  children: [
                    Icon(
                      Icons.alarm, 
                      size: 15, 
                      color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),

                    SizedBox(width: 3,),
                    Text("08:00 AM",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      letterSpacing: 0.1,
                    ),
                    )
                  ],
                )

              ],
            ),

            const SizedBox(height: 6,),

            Row(
              children: [

                Text("12H 30M",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  letterSpacing: 0.1,
                ),
                ),

                 SizedBox(width: 15,),

                 Text("4 Stops",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  letterSpacing: 0.1,
                ),
                ), 

                Spacer(),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),    
                  child: Text("Upcoming",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.green,
                    letterSpacing: 0.1,
                  ),
                  ) ,
                ) 
              ],
            )
          ],
        ),
      ),
    );
  }
}