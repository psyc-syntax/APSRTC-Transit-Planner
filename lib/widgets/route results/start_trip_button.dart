import 'package:flutter/material.dart';

class StartTripButton extends StatelessWidget{
  const StartTripButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        
      ),
      child: ElevatedButton(
        onPressed: (){},
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Start Trip", style: TextStyle(fontSize: 16)),
              Icon(Icons.bolt, size: 18),
            ],
          ),
        )
      ),
    );
  }
}