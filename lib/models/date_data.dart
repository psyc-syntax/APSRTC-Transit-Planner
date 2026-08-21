import 'package:intl/intl.dart';
import 'package:planner_demo/models/app_data.dart';




class DateTimeData {
  /// Converts a native DateTime into your planner's shared Map configuration structure
  Map<String, dynamic> dateDetailsGetter(DateTime dateTime) {
    return {
      "month": DateFormat('MMM').format(dateTime),   // e.g., "Jul"
      "day": dateTime.day,
      "weekDay": DateFormat('EEE').format(dateTime), // e.g., "Fri"
      "year": dateTime.year,
    };
  }

String displayDay(Map<String, dynamic> dateData) {
  final day = dateData['day'];

  if (day == null) {
    return '';
  }

  final date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    int.parse(day.toString()),
  );

  return DateFormat('EEE').format(date);
}

  String minToTime(int minutes) {
    minutes %= 1440;

    int hours = minutes ~/ 60;
    int min = minutes % 60;

    final String period = hours >= 12 ? "PM" : "AM";

    hours = hours % 12;
    if (hours == 0) {
      hours = 12;
    }

    return "${hours.toString().padLeft(2, '0')}:"
        "${min.toString().padLeft(2, '0')} $period";
  }

  String displayDayMonthYear(Map<String, dynamic> dateData){
    String dayStr = dateData["day"]?.toString() ?? "";
    String monthStr = dateData["month"]?.toString() ?? "";
    String yearStr = dateData["year"]?.toString() ?? "";

    return "$dayStr $monthStr, $yearStr";
  }

  String displayDayMonth(Map<String, dynamic> dateData) {
    // Convert everything to string safely to avoid type mismatch crashes
    String dayStr = dateData["day"]?.toString() ?? "";
    String monthStr = dateData["month"]?.toString() ?? "";
    String yearStr = dateData["year"]?.toString() ?? "";

    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(const Duration(days: 1));
    
    // Generate comparison strings for today
    String nowMonth = DateFormat('MMM').format(now);
    String nowYear = now.year.toString();

    // Generate comparison strings for tomorrow (handles month shifts automatically)
    String tomorrowMonth = DateFormat('MMM').format(tomorrow);
    String tomorrowYear = tomorrow.year.toString();

    // 1. Precise check for Today
    if (dayStr == now.day.toString() && monthStr == nowMonth && yearStr == nowYear) {
      return "Today";
    } 
    // 2. Precise check for Tomorrow
    else if (dayStr == tomorrow.day.toString() && monthStr == tomorrowMonth && yearStr == tomorrowYear) {
      return "Tomorrow";
    } 
    // 3. Fallback for every other date (No more returning empty strings!)
    else {
      return "$dayStr $monthStr".trim(); 
    }
  }

  int timeToMin(DateTime time) {
    return time.hour * 60 + time.minute;
  }


  int waitingTimeFinder(int arrivalTimeline, int departure) {
  // departure is already an absolute timeline value (e.g. 1500)
  if (departure >= 1440) {
    return departure - arrivalTimeline;
  }

  // departure is a clock time (0-1439)
  int arrivalClock = arrivalTimeline % 1440;

  int wait = departure - arrivalClock;

  if (wait < 0) {
    wait += 1440;
  }

  return wait;

}

int totalTimeCalc(Result results){
  final path = results.path;
  int totaltime = 0;
  for(int i = 0; i < path.length; i++){
    if(path[i].time != null){
      totaltime += path[i].time!;
    }
    if(i < path.length - 1 && i > 0){
      totaltime += waitingTimeFinder(path[i].arrivalTime, path[i].deptTime);
    }
  }
  return totaltime;

}

double totalDistanceCalc(Result results){
  
  final path = results.path;
  int totalTime = 0;
  for(int i = 0; i < path.length - 1; i++){
    if(path[i].time != null){
      totalTime += path[i].time!;
    }
    
  }

  return totalTime * getMultiplier(totalTime);
}

double getMultiplier(int totalTime) {
  if (totalTime <= 15) return 0.75;      // 45 km/h
  if (totalTime <= 30) return 0.70;      // 42 km/h
  if (totalTime <= 60) return 0.65;      // 40 km/h
  if (totalTime <= 120) return 0.60;     // 37.2 km/h
  if (totalTime <= 240) return 0.58;     // 34.8 km/h
  return 0.55;                           // 33 km/h
}

double totalTimeByDistance(int distance) {
  double baseTimeInMinutes;
  
  if (distance <= 100) {
    baseTimeInMinutes = (distance / 40.0) * 60;
  } else {
    baseTimeInMinutes = (distance / 50.0) * 60;
  }
  

  double trafficOverhead = baseTimeInMinutes * 0.10; 
  double restBreakOverhead = 0;
  
  if (baseTimeInMinutes > 180) { 
    restBreakOverhead = 30;
  }
  

  double totalTimeInMinutes = baseTimeInMinutes + trafficOverhead + restBreakOverhead;
  return totalTimeInMinutes;
}




  
}