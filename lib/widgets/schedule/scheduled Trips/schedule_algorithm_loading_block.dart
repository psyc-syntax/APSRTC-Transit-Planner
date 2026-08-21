import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPartWhileScheduleAlgorithmRunning extends StatelessWidget {
  const LoadingPartWhileScheduleAlgorithmRunning({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Takes only as much vertical space as needed
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 280,
              height: 180,
              child: Lottie.asset(
                'assets/markbus_route_finding_simple.json',
                repeat: true,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Finding the best trip...",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}