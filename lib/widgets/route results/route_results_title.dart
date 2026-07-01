import 'package:flutter/material.dart';


class RouteResultsTitle extends StatelessWidget {
  const RouteResultsTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),

      ],
    );
  }
}
