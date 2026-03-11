import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/shared/glowing_dot.dart';

class TopTitle extends StatelessWidget {
  const TopTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GlowingDot(dotColor: Colors.green),
              SizedBox(width: 8),
              Text(
                "OFFLINE ENGINE READY",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
      
          Row(
            children: [
              Icon(Icons.storage_rounded, size: 16),
              SizedBox(width: 6),
              Text("DATA VERSION", style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ],
      ),
    );
  }
}
