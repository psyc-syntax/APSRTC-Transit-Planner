import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimation extends StatelessWidget {
  final String status;

  const LoadingAnimation({
    super.key,
    this.status = "Finding your best trip...",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          SizedBox(
            width: 280,
            height: 180,
            child: Lottie.asset(
              'assets/markbus_route_finding_simple.json',
              repeat: true,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            status,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Searching routes and connections...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}