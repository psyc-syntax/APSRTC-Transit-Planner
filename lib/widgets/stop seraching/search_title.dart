import 'package:flutter/material.dart';

class SearchTitle extends StatelessWidget {
  const SearchTitle({super.key, required this.isbackneeded});

  final bool isbackneeded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //return button
        if(isbackneeded)
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back, 
              color: Theme.of(context).colorScheme.onSurface, 
              size: 24,
            ),
          ),

        //gap between title and return button
        if(isbackneeded)
          SizedBox(width: 16),

        //title and subtitle
        Text(
          "Select Stop",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
