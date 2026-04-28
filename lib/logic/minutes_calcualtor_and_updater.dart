import 'package:planner_demo/helpers/database_helper.dart';

class TaskService {
  final DatabaseHelper _dbhelper = DatabaseHelper();

  /// Convert "09:40 AM" total minutes from midnight
  int convertTimeToMinutes(String timeStr) {
    try {
      final parts = timeStr.trim().split(" ");
      if (parts.length != 2) return 0;

      final time = parts[0];
      final period = parts[1];

      final hm = time.split(":");
      if (hm.length != 2) return 0;

      int hour = int.parse(hm[0]);
      int minute = int.parse(hm[1]);

      if (period == "PM" && hour != 12) {
        hour += 12;
      }
      if (period == "AM" && hour == 12) {
        hour = 0;
      }

      return hour * 60 + minute;
    } catch (e) {
      return 0;
    }
  }

  //Add new columns to route_stops table
  Future<void> addTimeMinutesColumn() async {
    final db = await _dbhelper.database;

    try {
      await db.execute(
        "ALTER TABLE route_stops ADD COLUMN arr_time_min INTEGER",
      );
    } catch (_) {
      //column may already exist → ignore
    }

    try {
      await db.execute(
        "ALTER TABLE route_stops ADD COLUMN dept_time_min INTEGER",
      );
    } catch (_) {
      // column may already exist → ignore
    }
  }

  //Convert string time → integer minutes and update DB
  Future<void> updateTimeAsMinutes() async {
    final db = await _dbhelper.database;

    final List<Map<String, dynamic>> rows = await db.rawQuery(
      "SELECT oprsNo, scheduleArrTime, scheduleDepTime FROM route_stops",
    );

    final batch = db.batch();

    for (var row in rows) {
      String oprsNo = row["oprsNo"].toString();

      String arrivalTimeStr = row["scheduleArrTime"] ?? "";
      String deptTimeStr = row["scheduleDepTime"] ?? "";

      if (arrivalTimeStr.isEmpty || deptTimeStr.isEmpty) continue;

      int arrTime = convertTimeToMinutes(arrivalTimeStr);
      int deptTime = convertTimeToMinutes(deptTimeStr);

      batch.rawUpdate(
        '''
        UPDATE route_stops 
        SET arr_time_min = ?, dept_time_min = ?
        WHERE oprsNo = ?
        ''',
        [arrTime, deptTime, oprsNo],
      );
    }
  }
}