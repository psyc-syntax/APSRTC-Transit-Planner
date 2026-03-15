import 'package:flutter/material.dart';
import 'package:planner_demo/screens/home_screen.dart';
import 'package:planner_demo/screens/saved_trips_screen.dart';
import 'package:planner_demo/screens/stop_details_search_screen.dart';

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen>{
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    StopDetailsSearchScreen(),
    SavedTripsScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 0,
              offset: Offset(0, -3),
            )
          ]
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.search), 
              label: "ROUTE",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin), 
              label: 'STOPS',
            ),
        
            BottomNavigationBarItem(
              icon: Icon(Icons.save),
              label: "SAVED",
            )
          ]),
      ),
    );
  }

}