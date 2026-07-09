import 'package:flutter/material.dart';

class DevelopedByBlock extends StatelessWidget{
  const DevelopedByBlock({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
            Text("Developed by",
           
      ),

            Text("MANOG Labs", style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 22
            ),),

            SizedBox(height: 20,),

            Text("Made with ❤️ in India" ,style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 14,
          letterSpacing: 0.2,
          fontWeight: FontWeight.normal
        ),
        textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}