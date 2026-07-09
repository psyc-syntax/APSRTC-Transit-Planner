import 'package:flutter/material.dart';

class DataIncludeSingleParam extends StatelessWidget{
  const DataIncludeSingleParam({super.key, required this.icon, required this.detail});

  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).dividerColor, size: 20,),
        SizedBox(width: 4,),

        Text(detail, style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontSize: 12
        ),)
      ],
    );
  }
}