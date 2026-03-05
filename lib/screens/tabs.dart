import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen>{
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: (){}, 
        child: Text("kumar"),
      ),

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