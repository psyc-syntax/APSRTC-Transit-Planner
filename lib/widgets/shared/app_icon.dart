import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
  radius: 22,
  backgroundColor: Theme.of(context).colorScheme.primary,
  child: ClipOval(
    child: Image.asset(
      'icons/markBus_icon.png',
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    ),
  ),
);
  }
}
