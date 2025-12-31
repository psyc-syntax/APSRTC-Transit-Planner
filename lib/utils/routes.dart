import 'package:flutter/material.dart';
import 'package:planner_demo/pages/home_page.dart';
import 'package:planner_demo/pages/main_page.dart';
import 'package:planner_demo/pages/trip_location_selection_page.dart';
import 'package:planner_demo/pages/user_page.dart';


class AppRoutes {
  static const String main = '/';
  static const String home = '/home';
  static const String profile = 'profile';
  static const String locationsSelection = '/trip-location-selection';

  static Map<String, WidgetBuilder> routes = {
    main : (context) => MainPage(),
    home : (context) => HomePage(),
    profile : (context) => UserPage(),
    locationsSelection : (context) => TripLocationSelectionPage(),
  };
}