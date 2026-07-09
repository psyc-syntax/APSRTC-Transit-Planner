import 'package:flutter/material.dart';
import 'package:planner_demo/screens/support/Terms_and_condtions_screen.dart';
import 'package:planner_demo/screens/support/open_source_and_licenses_screen.dart';
import 'package:planner_demo/screens/support/privacy_and_policy_screen.dart';
import 'package:planner_demo/widgets/more%20options/support/about%20mark/description_block.dart';
import 'package:planner_demo/widgets/more%20options/support/about%20mark/developed_by_block.dart';
import 'package:planner_demo/widgets/more%20options/support/about%20mark/mark_title_block.dart';
import 'package:planner_demo/widgets/more%20options/support/about%20mark/policies_single_param_block.dart';
import 'package:planner_demo/widgets/more%20options/support/top_title.dart';

class AboutMarkScreen extends StatelessWidget{
  const AboutMarkScreen({super.key});

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

              SizedBox(height: 20,),

              MarkTitleBlock(),

              
              
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: DescriptionBlock(),
              ),

              DevelopedByBlock(),

              SizedBox(height: 60,),

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
                child: PoliciesSingleParamBlock(icon: Icons.description, detail: "Terms & Conditions",))

            ],
          ),
        ),
      ),
    );
  }
}