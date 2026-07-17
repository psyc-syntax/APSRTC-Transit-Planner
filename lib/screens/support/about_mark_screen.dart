import 'package:flutter/material.dart';
import 'package:planner_demo/screens/support/Terms_and_condtions_screen.dart';
import 'package:planner_demo/screens/support/open_source_and_licenses_screen.dart';
import 'package:planner_demo/screens/support/privacy_and_policy_screen.dart';
import 'package:planner_demo/widgets/more%20options/support/about%20mark/description_block.dart';
import 'package:planner_demo/widgets/more%20options/support/about%20mark/developed_by_block.dart';
import 'package:planner_demo/widgets/more%20options/support/about%20mark/mark_title_block.dart';
import 'package:planner_demo/widgets/more%20options/support/about%20mark/policies_single_param_block.dart';
import 'package:planner_demo/widgets/shared/top_title.dart';

class AboutMarkScreen extends StatelessWidget {
  const AboutMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,
      body: Stack(
        children: [
          // Layer 1: Scrollable Content
          SafeArea(
            bottom: false,
            top: true,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TopTitle(isbackNeeded: true, title: "About Mark",),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    // Combined horizontal padding with the 120px bottom padding to clear the gradient
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 120.0),
                    child: Column(
                      children: [
                        
                    
                        SizedBox(height: 20,),
                    
                        MarkTitleBlock(),
                    
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                          child: DescriptionBlock(),
                        ),
                    
                        SizedBox(height: 24,),
                    
                        DevelopedByBlock(),
                    
                        SizedBox(height: 50,),
                    
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return OpenSourceLicensesScreen();
                            }));
                          },
                          child: PoliciesSingleParamBlock(icon: Icons.balance, detail: "Open Source licenses",)
                        ),
                    
                        SizedBox(height: 4,),
                    
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return PrivacyPolicyScreen();
                            }));
                          },
                          child: PoliciesSingleParamBlock(icon: Icons.privacy_tip, detail: "Privacy Policy",)
                        ),
                    
                        SizedBox(height: 4,),
                    
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return TermsAndConditionsScreen();
                            }));
                          },
                          child: PoliciesSingleParamBlock(icon: Icons.description, detail: "Terms & Conditions",)
                        ),
                  
                  
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Layer 2: Telegram-Style Bottom Scrim Gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 120, // Height of the fade
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