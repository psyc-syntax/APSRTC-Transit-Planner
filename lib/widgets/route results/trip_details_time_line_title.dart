import "package:flutter/material.dart";

class TripDetailsTimeLineTitle extends StatelessWidget {
  const TripDetailsTimeLineTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Trip Details",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}