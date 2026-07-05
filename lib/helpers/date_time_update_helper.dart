import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planner_demo/providers/providers.dart';

void updateTempDateAndDefaultTime(WidgetRef ref, DateTime date) {
  final today = DateTime.now();
  final tomorrow = today.add(const Duration(days: 1));

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  ref.read(tempSelectedDateProvider.notifier).state = date;

  if (isSameDate(date, today)) {
    ref.read(tempDateCategoryProvider.notifier).state = "Today";
    ref.read(tempSelectedStartTimeProvider.notifier).state = today.hour * 60 + today.minute;
  } else if (isSameDate(date, tomorrow)) {
    ref.read(tempDateCategoryProvider.notifier).state = "Tomorrow";
    ref.read(tempSelectedStartTimeProvider.notifier).state = 480;
  } else {
    ref.read(tempDateCategoryProvider.notifier).state = "Custom";
    ref.read(tempSelectedStartTimeProvider.notifier).state = 480;
  }
}

void updateDefaultTime(WidgetRef ref){
  if(ref.read(tempDateCategoryProvider) == "Today"){
    ref.read(tempSelectedStartTimeProvider.notifier).state = DateTime.now().hour * 60 + DateTime.now().minute;
  }
  else {
    ref.read(tempSelectedStartTimeProvider.notifier).state = 480;
  }
}
void updateTempTime(WidgetRef ref, int time) {

 ref.read(tempSelectedStartTimeProvider.notifier).state = time;
}

void updateTempDate(WidgetRef ref, DateTime date) {
  final today = DateTime.now();
  final tomorrow = today.add(const Duration(days: 1));

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  ref.read(tempSelectedDateProvider.notifier).state = date;

  if (isSameDate(date, today)) {
    ref.read(tempDateCategoryProvider.notifier).state = "Today";
    
  } else if (isSameDate(date, tomorrow)) {
    ref.read(tempDateCategoryProvider.notifier).state = "Tomorrow";
    
  } else {
    ref.read(tempDateCategoryProvider.notifier).state = "Custom";
    
  }
}



void updateDateAndTime (WidgetRef ref){
  ref.read(selectedDateProvider.notifier).state = ref.read(tempSelectedDateProvider);
  ref.read(SelectedDateCategoryProvider.notifier).state = ref.read(tempDateCategoryProvider);
  ref.read(selectedStartTimeProvider.notifier).state = ref.read(tempSelectedStartTimeProvider);
}