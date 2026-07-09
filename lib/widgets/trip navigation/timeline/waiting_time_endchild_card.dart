import 'package:flutter/material.dart';


class WaitingTimeEndchild extends StatelessWidget{
  const WaitingTimeEndchild(
    {
      super.key,
      required this.duration
      }
    );

  final int duration;

  @override
  Widget build(BuildContext context) {

    double hours = (duration / 60);
    double minutes = (duration % 60);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.yellow.withAlpha(10),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.hourglass_empty_rounded, size: 14, color: Theme.of(context).colorScheme.onSurface),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "WAITING TIME",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${hours > 1 ? "${hours.toInt()}hour": ""} ${minutes.toInt()} min",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                   color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}