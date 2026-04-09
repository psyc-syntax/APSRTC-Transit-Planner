import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';

class RouteResultTripCard extends ConsumerWidget {
  const RouteResultTripCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the algorithm results
    final routeResultsList = ref.watch(markAlgorithmProvider);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Time and Duration
          Row(
            children: [
              Text(
                "08:00 - 09:30",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("2h 30m", style: Theme.of(context).textTheme.bodyMedium),
                  Text("4 stops", style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
          const Divider(height: 24),

          // Result Logic
          routeResultsList.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text("Error: $err", style: const TextStyle(color: Colors.red)),
            data: (results) {
              if (results.isEmpty) return const Text("No path found.");

              // HORIZONTAL ROLLING LIST
            return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final step = results[index];
            final stopName = step.keys.first;
            final distance = step.values.first;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "$stopName - ${distance.toStringAsFixed(1)} km",
                style: const TextStyle(fontSize: 16),
              ),
            );
            },
          );
            },
          ),
        ],
      ),
    );
  }}