import "package:flutter/material.dart";

class CircularColouredIcon extends StatelessWidget {
  final IconData iconData;
  final bool isfillColor;
  final Color color;
  

  const CircularColouredIcon({
    super.key,
    required this.iconData,
    this.isfillColor = true,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isfillColor ? color : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Icon(
        iconData,
        color: isfillColor ? Colors.white : color,
        size: 16,
      ),
    );
  }
}