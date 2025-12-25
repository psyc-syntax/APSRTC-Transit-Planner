import 'package:flutter/material.dart';
class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      currentIndex: selectedIndex,
      selectedItemColor: Colors.purple,
       unselectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "home",),
          

        BottomNavigationBarItem(
          icon:  Icon(Icons.save), 
          label: 'saved'
          ),

        BottomNavigationBarItem(
          icon: Icon(Icons.settings), 
          label: 'settings')
      ],
      );
  }
}