import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';

class ThemeSelectionBlock extends ConsumerWidget {
  const ThemeSelectionBlock({super.key});

 




  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(themeModeProvider);
    String selectedValue = switch (themeMode) {
  ThemeMode.system => "System Default",
  ThemeMode.light => "Light",
  ThemeMode.dark => "Dark",
};
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border.all(
          color: Theme.of(context).dividerColor
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Text(
                "Theme",
                style: Theme.of(context).textTheme.titleLarge
              ),
            ),


            Material(
              child: RadioListTile<String>(
                value: "System Default",
                groupValue: selectedValue,
                 visualDensity: const VisualDensity(vertical: -4),
                 horizontalTitleGap: 3,
                 tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                onChanged: (value) {
                  
                    ref.read(themeModeProvider.notifier).state = ThemeMode.system;
                   
                 
                },
                title: const Text("System Default"),
                contentPadding: EdgeInsets.zero,
              ),
            ),



            Material(
              child: RadioListTile<String>(
                value: "Light",
                groupValue: selectedValue,
                 visualDensity: const VisualDensity(vertical: -4),
                 horizontalTitleGap: 3,
                  tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                onChanged: (value) {
                  
                     ref.read(themeModeProvider.notifier).state = ThemeMode.light;
                },
                title: const Text("Light"),
                contentPadding: EdgeInsets.zero,
              ),
            ),



            Material(
              child: RadioListTile<String>(
                value: "Dark",
                groupValue: selectedValue,
                 visualDensity: const VisualDensity(vertical: -4),
                 horizontalTitleGap: 3,
                  tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                onChanged: (value) {
                 
                     ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
                 
                },
                title: const Text("Dark"),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
