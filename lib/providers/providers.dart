

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/models/date_data.dart';


enum SelectedDateCategory  {
  today,
  tomorrow,
  custom,
}

final startingPlaceIdProvider = StateProvider<String>((ref) => "");
final startingPlaceNameProvider = StateProvider<String>((ref) => "Leaving From");
final destinationPlaceIdProvider = StateProvider<String>((ref) => "");
final destinationPlaceNameProvider = StateProvider<String>((ref) => "Going To");
final isstartingPlaceSelectedProvider = StateProvider<bool>((ref) => false);
final isdestinationPlaceSelectedProvider = StateProvider<bool>((ref) => false);
final isMarkAlgorithmRunning = StateProvider<bool>((ref) => false);

final runAlgorithmTriggerProvider = StateProvider<int>((ref) => 0); 


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





final savedTripsProvider = StateProvider<List<Result>>((ref) => []);

Future<void> loadSavedTrips(WidgetRef ref) async {

  final trips = await DatabaseHelper().getSavedTrips();

  ref.read(savedTripsProvider.notifier).state = trips;
}

Future<void> saveTrip(
    WidgetRef ref,
    Result result,
) async{

  await DatabaseHelper().saveTrip(result);

  final trips =
      ref.read(savedTripsProvider);

  ref.read(savedTripsProvider.notifier).state = [

    result,

    ...trips,

  ];

}
