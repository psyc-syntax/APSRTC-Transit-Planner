import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/helpers/date_time_update_helper.dart';

import 'package:planner_demo/providers/providers.dart';

class TravelDateSelectionBlock extends ConsumerWidget {
  const TravelDateSelectionBlock({super.key});

 


  
  @override
  Widget build(BuildContext context, ref) {

  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (date != null) {
      
      
      updateTempDateAndDefaultTime(ref, date);
      
      
    }
  }


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // horizontal line
          Container(
            width: double.infinity,
            height: 2,
            color: Theme.of(context).dividerColor,
          ),

          //travel date title and select calendar button too
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  // travel date title with calendar icon
                  children: [
                    // travel date title with calendar icon
                    Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 16,
                    ),

                    SizedBox(width: 2),
                    Text(
                      "Travel Date", // travel date headding
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        
                        await pickDate();
                      },
                      child: Text(
                        "Select Calendar", // select calendar button
                        style: TextStyle(fontSize: 13, color: Colors.blue,
                        overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ),
                    Text(" >"),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //today button
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    

                      updateTempDateAndDefaultTime(ref, DateTime.now());
                  },
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: WidgetStateProperty.all(
                      ref.watch(tempDateCategoryProvider) == "Today"
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surfaceContainerHigh,
                    ),

                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(30),
                      ),
                    ),
                  ),

                  child: Text(
                    "Today",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: ref.watch(tempDateCategoryProvider) == "Today"
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),

              //tomorrow button
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    
                      updateTempDateAndDefaultTime(ref, DateTime.now().add(Duration(days: 1)));

                    
                  },

                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: WidgetStateProperty.all(
                      ref.watch(tempDateCategoryProvider) == "Tomorrow"
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surfaceContainerHigh,
                    ),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(30),
                      ),
                    ),
                  ),

                  child: Text(
                    "Tomorrow",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: ref.watch(tempDateCategoryProvider) == "Tomorrow"
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),

              // calendar icon button
              ElevatedButton(
                onPressed: () async {
                
                    
                  await pickDate();
                },
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  backgroundColor: WidgetStateProperty.all(
                    ref.watch(tempDateCategoryProvider) == "Custom"
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceContainerHigh,
                  ),

                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  ),

                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(30),
                    ),
                  ),
                ),
                child: Icon(
                  Icons.calendar_month,
                  color: ref.watch(tempDateCategoryProvider) == "Custom"
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
