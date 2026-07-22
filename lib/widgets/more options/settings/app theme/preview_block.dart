import 'package:flutter/material.dart';
import 'package:planner_demo/widgets/more%20options/settings/app%20theme/preview_block_demo_screen.dart';


class PreviewBlock extends StatelessWidget {
  const PreviewBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        // border: Border.all(
        //   // color: Theme.of(context).dividerColor
        // ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          crossAxisAlignment:  CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Preview",
                style: Theme.of(context).textTheme.titleLarge
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PreviewBlockDemoScreen(),
            )
          ],
        ),
      ),
    );
  }
}
