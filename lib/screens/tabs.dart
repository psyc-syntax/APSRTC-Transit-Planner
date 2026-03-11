import 'package:flutter/material.dart';
import 'package:planner_demo/screens/home_screen.dart';

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
    Text("Stops Screen"),
    Text("history screen"), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.alarm),
            label: "HISTORY",
          )
        ]),
    );
  }

}