import 'package:flutter/material.dart';
import 'package:planner_demo/screens/home_screen.dart';
import 'package:planner_demo/screens/saved_trips_screen.dart';
import 'package:planner_demo/screens/stop_search_screen.dart';

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
    StopSearchScreen(isbackneeded: false, isStartingStop: false),
    SavedTripsScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],


      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16,0, 16, 24),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.surface,
                  blurRadius: 26,
                  spreadRadius: 22,
                  offset: const Offset(0, 42),
                )
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: (index){
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search, size: 28,), 
                    label: "ROUTE",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.location_pin, size: 28,), 
                    label: 'STOPS',
                  ),
              
                  BottomNavigationBarItem(
                    icon: Icon(Icons.save, size: 28,),
                    label: "SAVED",
                  )
                ]),
            ),
          ),
        ),
      ),
    );
  }

}