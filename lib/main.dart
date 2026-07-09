import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/Theme/app_theme.dart';
import 'package:planner_demo/providers/providers.dart';
import 'package:planner_demo/screens/tabs.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(ProviderScope(child: const App()));
}

class App extends ConsumerWidget { 
  const App({super.key});

  

  @override
  Widget build(BuildContext context, ref) {

    final _themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      themeMode: _themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const TabsScreen(),
    );
  }
}