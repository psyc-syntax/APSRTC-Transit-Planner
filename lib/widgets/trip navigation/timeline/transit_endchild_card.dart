import 'package:flutter/material.dart';

class TransitEndchildCard extends StatelessWidget {
  const TransitEndchildCard({
    super.key,
    required this.timeString, 
    required this.title, 
    required this.subtitle
  });

  final String title;
  final String subtitle;
  final String timeString;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 1. Wrapped in Expanded so it calculates remaining width and wraps lines
            Expanded(
              child: Text(
                title.toUpperCase(),
                maxLines: null, // Allows infinite lines word-by-word
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
            
            // 2. Added spacing so long titles don't touch the vehicle info block
            const SizedBox(width: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              // Forces the vehicle info column to keep its exact required space
              mainAxisSize: MainAxisSize.min, 
              children: [
                Text(
                  "SERVICE NO", 
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle, 
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
