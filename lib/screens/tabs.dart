import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:planner_demo/screens/home_screen.dart';
import 'package:planner_demo/screens/more_options_screen.dart';
import 'package:planner_demo/screens/saved_trips_screen.dart';
import 'package:planner_demo/screens/stop_search_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const StopSearchScreen(isbackneeded: false, isStartingStop: false),
    const SavedTripsScreen(),
    const MoreOptionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //for floating effect
      extendBody: true,
      body: _pages[_selectedIndex],
      
      //build bottom navigation bar custom floating
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 15), 
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 2,
            ),
            // The shadow below the bar
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                blurRadius: 30,
                spreadRadius: 8,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              // makes the background blurry
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                // Semi-transparent background
                color: Theme.of(context).colorScheme.surfaceContainerHighest, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _navItem(Icons.home, "Home", 0)),
                    Expanded(child: _navItem(Icons.location_pin, "Stops", 1)),
                    Expanded(child: _navItem(Icons.save, "Trips", 2)),
                    Expanded(child: _navItem(Icons.more_horiz, "More", 3)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Simple helper to build each button
  Widget _navItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    Color _activeColor = Theme.of(context).colorScheme.primary;
    Color _inactiveColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isSelected ? _activeColor.withAlpha(50) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
        
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? _activeColor : _inactiveColor,
                  size: 22,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? _activeColor : _inactiveColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}