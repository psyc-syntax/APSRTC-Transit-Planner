import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';

class TimeDivisonBlock extends ConsumerWidget {
  const TimeDivisonBlock({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
            ref.read(selectedScheduleProvider.notifier).state = ScheduleType.morning;
          },
            child: _nativeDiv(
              context,
              "Morning",
              "5AM - 12PM",
              Icons.cloud,
              Colors.yellow,
              ref.watch(selectedScheduleProvider) == ScheduleType.morning
            ),
          ),
        ),

        SizedBox(width: 4,),

        Expanded(
          child: GestureDetector(
            onTap: () {
            ref.read(selectedScheduleProvider.notifier).state = ScheduleType.afternoon;
          },
            child: _nativeDiv(
              context,
              "Noon",
              "12PM - 5PM",
              Icons.light_mode,
              Colors.orange,
              ref.watch(selectedScheduleProvider) == ScheduleType.afternoon
            ),
          ),
        ),

        SizedBox(width: 4,),


        Expanded(
          child: GestureDetector(
            onTap: () {
            ref.read(selectedScheduleProvider.notifier).state = ScheduleType.evening;
          },
            child: _nativeDiv(
              context,
              "Night",
              "5PM - 12AM",
              Icons.dark_mode,
              Colors.blue,
              ref.watch(selectedScheduleProvider) == ScheduleType.evening
            ),
          ),
        ),
      ],
    );
  }
}

Widget _nativeDiv(
  BuildContext context,
  String title,
  String subTitle,
  IconData icon,
  Color iconColor,
  bool isSelected
) {


  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(32),
      border: Border.all(
        color: isSelected? Theme.of(context).colorScheme.surface: Theme.of(context).dividerColor
      ),
      color:  isSelected? Theme.of(context).colorScheme.primary: Colors.transparent
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: isSelected? Theme.of(context).colorScheme.onPrimary: iconColor),
              SizedBox(width: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  color: isSelected? Theme.of(context).colorScheme.onPrimary: Theme.of(context).colorScheme.onSurfaceVariant
                  
                ),
              ),
            ],
          ),
  
          SizedBox(height: 4),
  
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isSelected? Theme.of(context).colorScheme.onPrimary: Theme.of(context).colorScheme.onSurfaceVariant  
            ),
          ),
        ],
      ),
    ),
  );
}
