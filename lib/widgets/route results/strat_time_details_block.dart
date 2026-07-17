import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/widgets/route%20results/bottom_model_sheet_for_time_selection.dart';

class StratTimeDetailsBlock extends ConsumerWidget {
  const StratTimeDetailsBlock({super.key, required this.startTime});

  final String startTime;


  @override
  Widget build(BuildContext context, ref) {
    final _selectedDateData = ref.watch(selectedDateDataProvider);


    DateTimeData dateTimeData = DateTimeData();

    return GestureDetector(
      onTap: () {
        ref.read(tempDateCategoryProvider.notifier).state = ref.read(SelectedDateCategoryProvider);
        ref.read(tempSelectedDateProvider.notifier).state = ref.read(selectedDateProvider);
        showModalBottomSheet(
          context: context,
          builder: (context) => const BottomModelSheetForTimeSelection(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
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
                      "Start Time",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      // " ${_selectedDateData["day"]} ${_selectedDateData["month"]},  ${minToTime(int.parse(startTime))}",
                      "${
                        dateTimeData.displayDayMonth(_selectedDateData)
                        }, ${
                          dateTimeData.minToTime(int.parse(startTime))
                        }",

                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                Expanded(child: SizedBox(width: double.infinity)),

                Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 16,
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
