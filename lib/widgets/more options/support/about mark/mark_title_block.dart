import 'package:flutter/material.dart';

class MarkTitleBlock extends StatelessWidget{
  const MarkTitleBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
  Theme.of(context).brightness == Brightness.dark
      ? "assets/images/about_dark_image.png"
      : "assets/images/about_light_image.png",
);
  }
}