import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/shared/horizontal_line.dart';
import 'package:planner_demo/widgets/home/app_logo_text.dart';
import 'package:planner_demo/widgets/home/quick_history.dart';
import 'package:planner_demo/widgets/home/route_search_card.dart';
import 'package:planner_demo/widgets/home/home_header.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [


        //top title(offline engine ready, database info)
        TopTitle(),
        HorizontalLine(),
        
        
        //main title (app icon and dropdown menu)
        MainTitle(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0, 
              ),
              child: RouteSearchCard(), //trip details selection card
            ),
                  
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 42),
              child: QuickHistory(),
            )
          ],
        )
      ],
    );
  }
}