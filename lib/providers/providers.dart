

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/models/date_data.dart';
import 'package:planner_demo/screens/settings/app_theme_screen.dart';

enum SelectedDateCategory  {
  today,
  tomorrow,
  custom,
}

final startingPlaceIdProvider = StateProvider<String>((ref) => "");
final startingPlaceNameProvider = StateProvider<String>((ref) => "Select starting point");
final destinationPlaceIdProvider = StateProvider<String>((ref) => "");
final destinationPlaceNameProvider = StateProvider<String>((ref) => "Select destination point");
final isstartingPlaceSelectedProvider = StateProvider<bool>((ref) => false);
final isdestinationPlaceSelectedProvider = StateProvider<bool>((ref) => false);
final isMarkAlgorithmRunning = StateProvider<bool>((ref) => false);


final themeModeProvider = StateProvider<ThemeMode>((ref){
  return ThemeMode.system;
});

final SelectedDateCategoryProvider = StateProvider<String>((ref){
  return "Today";
});

final tempDateCategoryProvider = StateProvider<String>((ref){
  return "Today";
});

final tempSelectedDateProvider = StateProvider<DateTime>((ref){
  return DateTime.now();
});

final tempSelectedStartTimeProvider = StateProvider<int>((ref){
  final now = DateTime.now();
  return now.hour * 60 + now.minute;
});



final selectedStartTimeProvider = StateProvider<int>((ref){
  final now = DateTime.now();
  return now.hour * 60 + now.minute;
});



final selectedDateProvider = StateProvider<DateTime>((ref){
  return DateTime.now();
});



final selectedDateDataProvider =
Provider<Map<String, dynamic>>((ref) {

  final date = ref.watch(selectedDateProvider);

  return DateTimeData().dateDetailsGetter(date);

});

final routeResultsProvider = FutureProvider<Result?>((ref){
  final sourcePlaceId = ref.watch(startingPlaceIdProvider);
  final destinationPlaceId = ref.watch(destinationPlaceIdProvider);
  final startTime = ref.watch(selectedStartTimeProvider);

  return marksAlgorithm(sourcePlaceId, destinationPlaceId, startTime);
});

final runAlgorithmTriggerProvider = StateProvider<int>((ref) => 0); 
