import 'package:flutter/material.dart';

class HorizontalLine extends StatelessWidget{
  const HorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      color: Theme.of(context).dividerColor,
    );
  }
}