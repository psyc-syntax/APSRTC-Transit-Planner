

import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/more%20options/main_title.dart';
import 'package:planner_demo/widgets/more%20options/settings_block.dart';
import 'package:planner_demo/widgets/more%20options/support_block.dart';

class MoreOptionsScreen extends StatelessWidget {
  const MoreOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top : true,
      bottom: false,
      child: Scaffold(
        
        body: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainTitle(),
            SizedBox(height: 10,),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Text("Settings", style: Theme.of(context).textTheme.titleLarge,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SettingsBlock(),
            ),

            SizedBox(height: 20,),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Text("Support", style: Theme.of(context).textTheme.titleLarge,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SupportBlock(),
            ),
          ],
        )
      ),
    );
  }
}