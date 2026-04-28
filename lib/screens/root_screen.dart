import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/app_data_provider.dart';
import 'package:planner_demo/screens/loading_screen.dart';
import 'package:planner_demo/screens/tabs.dart';

class RootScreen extends ConsumerWidget{
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appData = ref.watch(appdataProvider);

    return appData.when(

      // If data is loaded, show the main tabs screen
      data: (appData) => const TabsScreen(),

      // If loading, show a loading indicator
      loading: () => const LoadingScreen(),

      // If there's an error, show an error message
      error: (error, _) => Scaffold(
        body: Center(child: Text('Error loading data: $error')),
      ),
    );

  }

}