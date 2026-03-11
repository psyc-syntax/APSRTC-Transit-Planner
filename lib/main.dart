import 'package:flutter/material.dart';
import 'package:planner_demo/Theme/app_theme.dart';
import 'package:planner_demo/screens/tabs.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}


class _AppState extends State<App> {
  final ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      themeMode: _themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: TabsScreen(),
      
    );
  }
}