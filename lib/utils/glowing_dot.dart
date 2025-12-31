import 'package:flutter/material.dart';

class GlowingDot extends StatelessWidget {
  final int dotColor;
  const GlowingDot({
    super.key,
    required this.dotColor,
    }
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(dotColor),
        boxShadow: [
          BoxShadow(
            color: Color(dotColor).withAlpha(120),
            blurRadius: 6,
            spreadRadius: 3,
            offset: Offset(0, 0),
          )
        ]
      ),
    );
  }
}