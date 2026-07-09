import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/widgets/more%20options/settings/update%20data/update_data_alert_box.dart';


class UpdateDataButton extends ConsumerWidget {
  const UpdateDataButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    
    return Container(
      decoration: BoxDecoration(        
         
      ),
      child: ElevatedButton(
        onPressed: () async {

          showDialog(context: context, builder: (ctx){
            return UpdateDataAlertBox();
          });

          

        },
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(30),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Check For Updates", style: TextStyle(fontSize: 16)),
              Icon(Icons.sync, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
