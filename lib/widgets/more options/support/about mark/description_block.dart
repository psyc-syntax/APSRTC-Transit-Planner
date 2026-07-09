import 'package:flutter/material.dart';


class DescriptionBlock extends StatelessWidget{
  const DescriptionBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Mark is an intelligent offline journey\nplanner designed to simplify APSRTC\ntravel by providing smart routes,\ntransfers and trip guidance.",
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 14,
          letterSpacing: 0.2,
          fontWeight: FontWeight.normal
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

