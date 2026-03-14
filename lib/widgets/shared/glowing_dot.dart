import 'package:flutter/material.dart';

class GlowingDot extends StatelessWidget{
  const GlowingDot({super.key, required this.dotColor});

  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: dotColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: dotColor.withAlpha(100),
            blurRadius: 2,
            spreadRadius: 1,
          )
        ]
      ),
    );
  }
}