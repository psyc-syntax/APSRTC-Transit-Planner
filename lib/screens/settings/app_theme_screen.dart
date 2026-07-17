import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/more%20options/settings/app%20theme/preview_block.dart';
import 'package:planner_demo/widgets/more%20options/settings/app%20theme/theme_selection_block.dart';
import 'package:planner_demo/widgets/shared/top_title.dart';

class AppThemeScreen extends StatelessWidget {
  const AppThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color bgColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,
      body: Stack(
        children: [
          // Layer 1: Content Layout Tree
          SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const TopTitle(isbackNeeded: true, title: "App Theme"),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      // Added 120px bottom padding to allow preview elements to scroll completely past the gradient layer
                      padding: const EdgeInsets.only(bottom: 120.0),
                      child: Column(
                        children: const [
                          ThemeSelectionBlock(),
                          SizedBox(height: 16),
                          PreviewBlock(),
                          
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Layer 2: Telegram-Style Ambient Bottom Scrim Gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 120, // Height of the fade zone
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      bgColor.withOpacity(0.0),
                      bgColor.withOpacity(0.8),
                      bgColor,
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}