import 'package:flutter/material.dart';


class TripNavLocationDetailsSingleParam extends StatelessWidget{
  const TripNavLocationDetailsSingleParam(
    {
      super.key,
      required this.icon,
      required this.paramDetail,

      required this.title,
      required this.iconColor,
    }
  );

  final IconData icon;
  final Color iconColor;
  final String title;

  final String paramDetail;
  @override
  Widget build(BuildContext context) {
    return Row(

      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

         Icon(
                icon,
                size: 18,
                color: iconColor,
            ),

        SizedBox(width: 2,),

        Column(
        children: [
          Row(
            children: [
             
      
              Text(title, 
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 12,
                letterSpacing: 0.1
              )
              )
            ],
          ),
      
          
      
          Text(
            paramDetail,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 14,
            letterSpacing: 0.1
          ),),
      
        ],
      ),
      ]
    );
  }
}