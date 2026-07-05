import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/providers/providers.dart';

class DayParamContainerForBottomModelSheet extends ConsumerWidget {
  const DayParamContainerForBottomModelSheet({
    super.key,
    required this.dateCategory,
  });

  final String dateCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTimeData dateTimeData = DateTimeData();
    
    // 1. WATCH the provider so the UI updates automatically
    final selectedCategory = ref.watch(tempDateCategoryProvider);
    final isSelected = selectedCategory == dateCategory;

    // 2. Determine the text BEFORE building the widget tree
    String getDateText() {
      // If this container isn't selected, return blank space to maintain height
      

      // If it IS selected, figure out what date string to show based on its category
      if (dateCategory == "Today") {
        return  dateTimeData.displayDayMonthYear(
            dateTimeData.dateDetailsGetter(DateTime.now()));
      } else if (dateCategory == "Tomorrow") {
        return dateTimeData.displayDayMonthYear(
            dateTimeData.dateDetailsGetter(DateTime.now().add(const Duration(days: 1))));
      } else if (dateCategory == "Custom") {
        // Grab the custom date from your provider
          if(ref.read(tempDateCategoryProvider) == "Custom"){
            return dateTimeData.displayDayMonthYear(
            dateTimeData.dateDetailsGetter(ref.read(tempSelectedDateProvider)));
          }
          return "                ";
        }
        return "            ";

      }
    

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.onSurfaceVariant
              : Theme.of(context).dividerColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 24,
              color: isSelected
                  ? Theme.of(context).colorScheme.onSurfaceVariant
                  : Theme.of(context).dividerColor,
            ),
            const SizedBox(height: 8),
            Text(
              dateCategory,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 12,
                  ),
            ),
            
            // 3. Simply pass the evaluated string here!
            Text(
              getDateText(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}