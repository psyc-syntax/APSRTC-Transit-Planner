
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:planner_demo/helpers/bin_files_helper.dart';
import 'package:planner_demo/helpers/database_helper.dart';
import 'package:planner_demo/logic/marks_algorithm.dart';
import 'package:planner_demo/logic/marks_schedule_trips_algorithm.dart';
import 'package:planner_demo/models/app_data.dart';
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
final startingLatProvider = StateProvider<double>((ref) => 0.0);
final startingLonProvider = StateProvider<double>((ref) => 0.0);
final destinationLatProvider = StateProvider<double>((ref) => 0.0);
final destinationLonProvider = StateProvider<double>((ref) => 0.0);

final isMarkAlgorithmRunning = StateProvider<bool>((ref) => false);

final runAlgorithmTriggerProvider = StateProvider<int>((ref) => 0); 

final runMorningScheduleAlgorithmTriggerProvider = StateProvider<int>((ref) => 0);
final isMorningScheduleAlgorithmRunning = StateProvider<bool>((ref) => false);

final runNoonScheduleAlgorithmTriggerProvider = StateProvider<int>((ref) => 0);
final isNoonScheduleAlgorithmRunning = StateProvider<bool>((ref) => false);

final runEveningScheduleAlgorithmTriggerProvider = StateProvider<int>((ref) => 0);
final isEveningScheduleAlgorithmRunning = StateProvider<bool>((ref) => false);




//theme provider
final themeModeProvider = StateProvider<ThemeMode>((ref){
  return ThemeMode.system;
});

//selecteddatecategory providers
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


//start time providers
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



final routeResultsProvider = FutureProvider<Result?>((ref) async {

  ref.watch(runAlgorithmTriggerProvider);


  final sourcePlaceId = ref.watch(startingPlaceIdProvider);
  final destinationPlaceId = ref.watch(destinationPlaceIdProvider);

  final startTime = ref.watch(selectedStartTimeProvider);

   print('RUNNING ALGORITHM WITH TIME: $startTime');

  return marksAlgorithm(sourcePlaceId, destinationPlaceId, startTime);
});


enum ScheduleType {
  morning,
  afternoon,
  evening,
}

final selectedScheduleProvider =
    StateProvider<ScheduleType>((ref) => ScheduleType.morning);

final binaryDataPathProvider = FutureProvider<String>((ref) async {
  print("PREPARING BINARY FILES");

  final path = await prepareBinaryFiles();

  print("BINARY FILES READY: $path");

  return path;
});


final morningScheduleTripsProvider = FutureProvider<List<Result?>>((ref) async{
  ref.watch(runMorningScheduleAlgorithmTriggerProvider);

  final sourcePlaceId = ref.watch(startingPlaceIdProvider);
  final destinationPlaceId = ref.watch(destinationPlaceIdProvider);
  
  final double lat1 = ref.watch(startingLatProvider);
  final double lon1 = ref.watch(startingLonProvider);
  final double lat2 = ref.watch(destinationLatProvider);
  final double lon2 = ref.watch(destinationLonProvider);
  final dataPath = await ref.watch(binaryDataPathProvider.future);
  
  final startTime = 300;
  final endTime = 719;

  print('RUNNING MORNING SCHEDULE ALGORITHM WITH TIME: $startTime');

  return marksScheduleAlgorithm(sourcePlaceId, destinationPlaceId, startTime, endTime, lat1, lon1, lat2, lon2, dataPath);


});

final noonScheduleTripsProvider = FutureProvider<List<Result?>>((ref)async{
  ref.watch(runNoonScheduleAlgorithmTriggerProvider);

  final sourcePlaceId = ref.watch(startingPlaceIdProvider);
  final destinationPlaceId = ref.watch(destinationPlaceIdProvider);
  final startTime = 720;
  final endTime = 1019;

  final double lat1 = ref.watch(startingLatProvider);
  final double lon1 = ref.watch(startingLonProvider);
  final double lat2 = ref.watch(destinationLatProvider);
  final double lon2 = ref.watch(destinationLonProvider);
  final dataPath = await ref.watch(binaryDataPathProvider.future);


  print('RUNNING NOON SCHEDULE ALGORITHM WITH TIME: $startTime');

  return marksScheduleAlgorithm(sourcePlaceId, destinationPlaceId, startTime, endTime, lat1, lon1, lat2, lon2, dataPath);


});

final eveningScheduleTripsProvider = FutureProvider<List<Result?>>((ref)async{
  
  ref.watch(runEveningScheduleAlgorithmTriggerProvider);

  final sourcePlaceId = ref.watch(startingPlaceIdProvider);
  final destinationPlaceId = ref.watch(destinationPlaceIdProvider);
  final startTime = 1020;
  final endTime = 1439;

  final double lat1 = ref.watch(startingLatProvider);
  final double lon1 = ref.watch(startingLonProvider);
  final double lat2 = ref.watch(destinationLatProvider);
  final double lon2 = ref.watch(destinationLonProvider);
  final dataPath = await ref.watch(binaryDataPathProvider.future);


  print('RUNNING evening SCHEDULE ALGORITHM WITH TIME: $startTime');

  return marksScheduleAlgorithm(sourcePlaceId, destinationPlaceId, startTime, endTime, lat1, lon1, lat2, lon2, dataPath);


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
