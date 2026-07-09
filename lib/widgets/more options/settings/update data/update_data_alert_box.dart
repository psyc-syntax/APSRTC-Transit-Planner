import 'package:flutter/material.dart';


class UpdateDataAlertBox extends StatelessWidget{
  const UpdateDataAlertBox({super.key});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("No data updates available", style: Theme.of(context).textTheme.titleSmall?.copyWith(
          letterSpacing: 0.1,
        ),),
      ),
    );
  }
}