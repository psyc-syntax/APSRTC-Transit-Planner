import 'package:flutter/material.dart';


class DescriptionBlock extends StatelessWidget{
  const DescriptionBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("markBus is your smart, offline travel companion. Designed for Andhra Pradesh commuters, it simplifies your journey with instant routes, seamless transfer tracking, and reliable trip guidance — all without needing an internet connection.",
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

