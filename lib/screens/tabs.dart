
import 'package:flutter/material.dart';
import 'package:planner_demo/screens/home_screen.dart';
import 'package:planner_demo/screens/more_options_screen.dart';
import 'package:planner_demo/screens/trips_screen.dart';
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
    const TripsScreen(),
    const MoreOptionsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Dynamically fetch the scaffold background color for a perfect seamless fade
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      // Keeps the screen content scrolling entirely behind the floating nav bar area
      extendBody: true,
      
      // FIX: Changed body to a Stack to host the ambient Telegram-style fade layer
      body: Stack(
        children: [
          // Layer 1: The actual active screen content
          _pages[_selectedIndex],

          // Layer 2: True Telegram-Style Ambient Bottom Scrim Gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 140, // Generous height gives the gradient plenty of runway to fade out smoothly
            child: IgnorePointer(
              // CRITICAL: Allows users to click and scroll scrollviews right through the gradient layer
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      bgColor.withOpacity(0.0), // Starts completely transparent up high
                      bgColor.withOpacity(0.5), // Soft intermediate transition
                      bgColor.withOpacity(0.9), // Richer buildup
                      bgColor,                  // Closes 100% solid at the absolute device edge
                    ],
                    stops: const [0.0, 0.4, 0.8, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Custom floating navigation bar (now cleanly separated from the background mask)
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      
      child: Padding(
        
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: Container(
          // Translucent Floating Navigation Bar Pill
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
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
    );
  }

  // Simple helper to build each button
  Widget _navItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    Color activeColor = Theme.of(context).colorScheme.primary;
    Color inactiveColor = Theme.of(context).colorScheme.onSurfaceVariant;

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
            color: isSelected ? activeColor.withAlpha(50) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? activeColor : inactiveColor,
                  size: 22,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? activeColor : inactiveColor,
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