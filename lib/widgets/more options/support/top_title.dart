import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget{
  const TopTitle({super.key});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 24,
                    ),
                  ),

                  SizedBox(width: 16),
                  Text(
                    "About Mark",
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),

                  
                ],
              );
  }
}