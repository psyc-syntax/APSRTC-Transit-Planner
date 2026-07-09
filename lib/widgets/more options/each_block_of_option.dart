import 'package:flutter/material.dart';

class EachBlockOfOption extends StatelessWidget{
  const EachBlockOfOption({
    super.key,
    required this.icon,
    required this.title
  });

  final IconData icon;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 16, top: 8, bottom: 6),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(icon, color: Theme.of(context).disabledColor, size: 18),
                  SizedBox(width: 10,),
                  Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w300
                  )
                  ,),
                ],),
      
                Icon(Icons.arrow_right, color: Theme.of(context).disabledColor, ),
              ],
            ),
    );
    
    
  }
}