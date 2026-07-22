import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/data_include_single_param.dart';

class DataIncludesBlock extends StatelessWidget{
  const DataIncludesBlock({super.key});


  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).dividerColor
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Data Includes",style: Theme.of(context).textTheme.titleLarge),

            SizedBox(height: 10,),

            DataIncludeSingleParam(icon: Icons.route, detail: "Routes & Services",),
            DataIncludeSingleParam(icon: Icons.info, detail: "Stop Information"),
            DataIncludeSingleParam(icon: Icons.timelapse, detail: "Timetables"),
            DataIncludeSingleParam(icon: Icons.route, detail: "Routes & Services"),

              
          ],
        ),
      ),
    );

  }

}