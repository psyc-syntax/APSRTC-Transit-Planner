import 'package:flutter/material.dart';

class FindOptimalRouteButton extends StatelessWidget{
  const FindOptimalRouteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlpha(75),
            blurRadius: 16.0,
            offset: Offset(0, 8),
          )
        ]
      ),
      child: ElevatedButton(
        onPressed: (){}, 
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("FIND OPTIMAL ROUTE"),
              Icon(Icons.bolt, size: 24,),
            ],
          ),
        ),
      ),
    );
  }
}