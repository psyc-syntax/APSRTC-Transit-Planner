import 'package:flutter/material.dart';
import 'package:planner_demo/screens/settings/app_theme_screen.dart';
import 'package:planner_demo/screens/settings/update_data_screen.dart';
import 'package:planner_demo/widgets/more%20options/each_block_of_option.dart';

class SettingsBlock extends StatelessWidget {
  const SettingsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          SizedBox(height: 6),

          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AppThemeScreen();
                  },
                ),
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            child: EachBlockOfOption(title: "App Theme", icon: Icons.dark_mode)
          ),

          Padding(
            padding: EdgeInsets.only(left: 36, right: 22),
            child: Divider(height: 1, color: theme.dividerColor),
          ),

          InkWell(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
                  return UpdateDataScreen();
                })
              );
            },

             splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),

          
          child: EachBlockOfOption(title: "Update Data", icon: Icons.update)
          ),

          SizedBox(height: 8),
        ],
      ),
    );
  }
}
