import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/more%20options/settings/app%20theme/preview_block.dart';
import 'package:planner_demo/widgets/more%20options/settings/app%20theme/theme_selection_block.dart';
import 'package:planner_demo/widgets/more%20options/settings/app%20theme/top_title.dart';

class AppThemeScreen extends StatelessWidget {
  const AppThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [

              TopTitle(),

              SizedBox(height: 16,),

              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ThemeSelectionBlock(),
                      SizedBox(height: 16,),
                  
                  PreviewBlock()
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
