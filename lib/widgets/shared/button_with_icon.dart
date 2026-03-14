import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    super.key, 
    required this.icon, 
    this.iconsize = 24,
    this.elevation = 1,
    this.fillColor = Colors.white,
    this.iconColor = Colors.black54,
    });

  final IconData icon;
  final double iconsize;
  final Color fillColor ;
  final Color iconColor ;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: fillColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(icon, color: iconColor, size: iconsize),
      ),
    );
  }
}
