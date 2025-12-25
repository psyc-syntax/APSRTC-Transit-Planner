import 'package:flutter/material.dart';
import 'package:planner_demo/pages/home_page.dart';
import 'package:planner_demo/pages/saved_trips_page.dart';
import 'package:planner_demo/pages/user_page.dart';
import 'package:planner_demo/utils/bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //pages index intialization
  int selectedIndex = 0;

  //list of the pages
  final List<Widget> pages = [
    HomePage(),
    SavedTripsPage(),
    UserPage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: (index){
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}