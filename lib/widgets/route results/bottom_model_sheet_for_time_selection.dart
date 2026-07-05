import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:planner_demo/helpers/date_time_update_helper.dart";

import "package:planner_demo/providers/providers.dart";

import "package:planner_demo/widgets/route%20results/day_param_container_for_bottom_model_sheet.dart";



class BottomModelSheetForTimeSelection extends ConsumerWidget {
  const BottomModelSheetForTimeSelection({super.key});

  

  

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
      
      updateTempDate(ref, date);
    }
  }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),

                Text(
                  "SELECT START TIME",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 18),
                ),

                GestureDetector(
                  onTap: () {
                    // Handle clear button press
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  child: Icon(Icons.clear),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              const SizedBox(width: 12),

              GestureDetector(
                onTap: () {
                  // Handle day parameter press
                    updateTempDate(ref, DateTime.now());

                  
                },
                child: DayParamContainerForBottomModelSheet(
                  dateCategory: "Today",
                  
                  ),
                ),

              const SizedBox(width: 12),

              GestureDetector(
                onTap: () {
                  // Handle day parameter press
                  updateTempDate(ref, DateTime.now().add(Duration(days: 1)));
                },
                child: DayParamContainerForBottomModelSheet(
                      dateCategory: "Tomorrow",
                    ),
                  ),

              const SizedBox(width: 12),

              GestureDetector(
                onTap: () async {
                  // Handle day parameter press
                  
                  await pickDate();
                  
                   
                  
                },
                child: DayParamContainerForBottomModelSheet(
                  dateCategory: "Custom",
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  brightness: Theme.of(context).brightness,
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 26),
                  ),

                  selectionHandleColor: Theme.of(context).colorScheme.primary,

                  barBackgroundColor: Colors.transparent,
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.now(),
                  use24hFormat: false,
                  onDateTimeChanged: (DateTime value) {
                    // Handle the selected date here
                    // ref.read(selectedStartTimeProvider.notifier).state = value.hour * 60 + value.minute;
                    updateTempTime(ref, value.hour * 60 + value.minute);
                  },
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                print(ref.watch(selectedStartTimeProvider));

               updateDateAndTime(ref);

                ref.read(runAlgorithmTriggerProvider.notifier).state++;
                ref.read(isMarkAlgorithmRunning.notifier).state = true;

                

                Navigator.pop(context);
              },
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(30),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Done", style: TextStyle(fontSize: 16))],
                ),
              ),
            ),
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}
