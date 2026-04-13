import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/Theme/app_theme.dart';
import 'package:planner_demo/providers/app_data_provider.dart';
import 'package:planner_demo/screens/tabs.dart';

void main() {
  runApp(ProviderScope(child: const App()));
}

class App extends ConsumerStatefulWidget { 
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}


class _AppState extends ConsumerState<App> {
  final ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    ref.watch(appDataProvider); // Ensure app data is loaded before building the UI
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      themeMode: _themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: TabsScreen(),
      
    );
  }
}