import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/helpers/date_time_update_helper.dart';
import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/providers/providers.dart';

class ScheduleDaySelectionBlock extends ConsumerWidget {
  const ScheduleDaySelectionBlock({
    super.key,
    required this.startTime,
    required this.startTimeMin,
    required this.inHome,
  });

  final String startTime;
  final int startTimeMin;
  final bool inHome;

  @override
  Widget build(BuildContext context, ref) {
    final _selectedDateData = ref.watch(selectedDateDataProvider);
    Future<void> pickDate() async {
      DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
      );

      if (date != null) {
        updateTempDate(ref, date);
        updateDateAndTime(ref);
      }
    }

    DateTimeData dateTimeData = DateTimeData();

    return GestureDetector(
      onTap: () {
        ref.read(tempDateCategoryProvider.notifier).state = ref.read(
          SelectedDateCategoryProvider,
        );
        ref.read(tempSelectedDateProvider.notifier).state = ref.read(
          selectedDateProvider,
        );
        pickDate();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                SizedBox(width: 12),

                Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 20,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Schedule Day",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      // " ${_selectedDateData["day"]} ${_selectedDateData["month"]},  ${minToTime(int.parse(startTime))}",
                      "${dateTimeData.displayDay(_selectedDateData)}, ${dateTimeData.displayDayMonth(_selectedDateData)}",

                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Expanded(child: SizedBox(width: double.infinity)),

                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      updateTempDate(ref, DateTime.now());
                      updateDateAndTime(ref);
                    },
                    style: Theme.of(context).elevatedButtonTheme.style
                        ?.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                            ref.watch(tempDateCategoryProvider) == "Today"
                                ? Theme.of(context).colorScheme.primaryFixedDim
                                : Theme.of(context).colorScheme.surfaceContainerHigh,
                          ),
                          

                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 4),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(32),
                            ),
                          ),
                        ),

                    child: Text(
                      "Today",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ref.watch(tempDateCategoryProvider) == "Today"
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 14,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),

                Expanded(child: SizedBox(width: double.infinity)),

                //tomorrow button
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      updateTempDate(
                        ref,
                        DateTime.now().add(Duration(days: 1)),
                      );
                      updateDateAndTime(ref);
                    },

                    style: Theme.of(context).elevatedButtonTheme.style
                        ?.copyWith(
                          backgroundColor: WidgetStateProperty.all(
                            ref.watch(tempDateCategoryProvider) == "Tomorrow"
                                ? Theme.of(context).colorScheme.primaryFixedDim
                                : Theme.of(context).colorScheme.surfaceContainerHigh,
                          ),
                          
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 8),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(32),
                            ),
                          ),
                        ),

                    child: Text(
                      "Tomorrow",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ref.watch(tempDateCategoryProvider) == "Tomorrow"
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 14,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
