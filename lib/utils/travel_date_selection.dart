import 'package:flutter/material.dart';

class TravelDateSelection extends StatefulWidget {
  const TravelDateSelection({super.key});

  @override
  State<TravelDateSelection> createState() => _TravelDateSelectionState();
}

class _TravelDateSelectionState extends State<TravelDateSelection> {
  bool todaySelected = false;
  bool tomorrowSelected = false;
  bool dateselected = false;
  bool calendarselected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // headding
        Text(
          "TRAVEL DATE",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),

        //gap between
        SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //today button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todaySelected = !todaySelected;
                  tomorrowSelected = false;
                  calendarselected = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: todaySelected
                    ? Colors.blue[900]
                    : Colors.grey[200],
                elevation: todaySelected ? 2 : 0,
                fixedSize: Size(130, 40),
              ),
              child: Text(
                "Today",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: todaySelected ? Colors.white : Colors.black,
                ),
              ),
            ),

            SizedBox(width: 12),

            //tomorrow button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tomorrowSelected = !tomorrowSelected;
                  todaySelected = false;
                  calendarselected = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tomorrowSelected
                    ? Colors.blue[900]
                    : Colors.grey[200],
                elevation: tomorrowSelected ? 2 : 0,
                fixedSize: Size(130, 40),
              ),
              child: Text(
                "Tomorrow",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: tomorrowSelected ? Colors.white : Colors.black,
                ),
              ),
            ),

            //date button
            SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  calendarselected = !calendarselected;
                  todaySelected = false;
                  tomorrowSelected = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: calendarselected
                    ? Colors.blue[900]
                    : Colors.grey[200],
                elevation: calendarselected ? 2 : 0,
                fixedSize: Size(60, 40),
                padding: EdgeInsets.all(0),
              ),
              child: Center(
                child: Icon(
                  Icons.calendar_month,
                  size: 30,
                  color: calendarselected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
