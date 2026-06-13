
import "package:flutter/material.dart";

class TripSuggestionBlock extends StatelessWidget {
  const TripSuggestionBlock({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Theme.of(  context).colorScheme.surfaceContainerHighest,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),

        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bus_alert,),
        
                const SizedBox(width: 10,),
        
                Text("Next Recommended Trip",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
        
              ],
            ),

            SizedBox(height: 20,),

            Row(
              children: [
                Text("Kakinada",
                  style: Theme.of(context).textTheme.titleLarge
                ),
                const SizedBox(width: 10,),
                const Icon(Icons.arrow_right_alt_rounded),
                const SizedBox(width: 10,),
                Text("Vijayawada",
                  style: Theme.of(context).textTheme.titleLarge
                ),
              ],
            ),

            const SizedBox(height: 6,),

            Row(
              children: [
                Text("08:00 AM - 09:30 PM",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18
                  )
                ),
              ],
            ),

            Row(
              children: [
                Text("12h 10m",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    letterSpacing: 0.1,
                  )
                ),

                SizedBox(width: 6,),

                Icon(Icons.stop_circle_outlined, size: 8,),

                SizedBox(width: 6,),

                Text(" 3 Stops",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    letterSpacing: 0.1,
                  )
                ),
              ],
            ),

            SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: double.infinity, vertical: 6),
                child: Text(""),
              ),
            ),

            SizedBox(height: 10,),

            Text("You should leave in",
              style: Theme.of(context).textTheme.titleSmall
            ),

            Text("20 mins",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 26,
              color: Colors.green,
              fontWeight: FontWeight.bold
            ),
            ),

            Text("to reach your boarding stop on time",
              style: Theme.of(context).textTheme.titleSmall
            ),

          ],
        ),
      ),
    );
  }
}