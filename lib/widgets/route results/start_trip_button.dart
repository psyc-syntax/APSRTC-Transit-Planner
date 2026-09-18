import 'package:flutter/material.dart';

class ShowMoreTripsButton extends StatelessWidget {
  const ShowMoreTripsButton({
    super.key,
    required this.showAllTrips,
    required this.onPressed,
  });

  final bool showAllTrips;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: ElevatedButton(
        onPressed: onPressed,

        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(32),
            ),
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 18,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showAllTrips
                    ? "Show Less"
                    : "Show More Trips",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(width: 2),

              Icon(
                showAllTrips
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}