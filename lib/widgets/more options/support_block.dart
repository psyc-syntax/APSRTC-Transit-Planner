import 'package:flutter/material.dart';
import 'package:planner_demo/screens/support/about_mark_screen.dart';
import 'package:planner_demo/screens/support/contack_support_screen.dart';
import 'package:planner_demo/widgets/more%20options/each_block_of_option.dart';

class SupportBlock extends StatelessWidget{
  const SupportBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).dividerColor
        )
      ),
      child: Column(
        children: [

          SizedBox(height: 6,),

          
      
          
           InkWell(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
                  return ContactScreen();
                })
              );
            },

            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),

            child: EachBlockOfOption(
              title: "Contact Support", icon: Icons.mail_outline,
            )
          ),
         
      
          Padding(
            padding: EdgeInsets.only(left: 36, right: 22),
            child: Divider(
              height: 1,
              color: theme.dividerColor,
            ),
          ),
      
      
         InkWell(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
                  return AboutMarkScreen();
                })
              );
            },

             splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
           child : EachBlockOfOption(title: "About Mark", icon: Icons.info,),
         ),
      
          SizedBox(height: 8,)
      
      
      
          
      
        ],
      ),
    );
  }
}