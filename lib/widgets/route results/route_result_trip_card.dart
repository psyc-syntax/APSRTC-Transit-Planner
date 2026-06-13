import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';

class RouteResultTripCard extends ConsumerWidget {
  const RouteResultTripCard({
    super.key,
    
    });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the algorithm results
  //   final routeResultsList = ref.watch(markAlgorithmProvider);
    final startingPlacename = ref.watch(startingPlaceNameProvider);

  //   return routeResultsList.when(
  // loading: () => const Center(child: CircularProgressIndicator()),
  // error: (err, stack) =>
  //     Text("Error: $err", style: const TextStyle(color: Colors.red)),
  // data: (results) {
  //   if (results.isEmpty) return const Text("No path found.");

  //   int hours = (((results.last.values.first.toDouble().round() / 20) * 30) / 60).toInt();
  //   int minutes = (((results.last.values.first.toDouble().round() / 20) * 30) % 60).toInt();
    
  int minutes = 0;
  int hours = 0;
  final results = [];
  
   
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
          // Top Row
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
                  Text("${hours}H ${minutes != 0 ? "$minutes MIN" : ""}"),
                  Text("${results.length - 1} stops"),
                ],
              ),
            ],
          ),

          const Divider(height: 24),

          //ListView.builder INSIDE ONE CARD
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: results.length + 1, // +1 for starting point
            itemBuilder: (context, index) {
              // First item = starting place
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "$startingPlacename - 0 km",
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }

              final step = results[index - 1];
              final stopName = step.keys.first;
              final distance = step.values.first;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "$stopName - ${distance.toStringAsFixed(1)} km",
                  style: const TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
// );
// }
}
