import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/data_includes_block.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/data_version_block.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/database_size_block.dart';
import 'package:planner_demo/widgets/shared/top_title.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/update_data_buttoon.dart';

class UpdateDataScreen extends StatelessWidget {
  const UpdateDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color bgColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 16,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const UpdateDataButton(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          // Layer 1: Content Layout Tree
          SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopTitle(isbackNeeded: true, title: "Update Data"),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      // Increased bottom padding to clear both the gradient and the FAB
                      padding: const EdgeInsets.only(bottom: 140.0),
                      child: Column(
                        children: const [
                          DataVersionBlock(),
                          SizedBox(height: 10),
                          DatabaseSizeBlock(),
                          SizedBox(height: 10),
                          DataIncludesBlock(),
                         
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Layer 2: Ambient Bottom Scrim Gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 140, // Fade height spanning behind the bottom button
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