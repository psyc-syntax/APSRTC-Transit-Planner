import 'package:flutter/material.dart';

import 'package:planner_demo/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // color theme
        primaryColor: Colors.blue[900],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.deepPurple
        ),

        // appbar theme
        appBarTheme: AppBarThemeData(
          backgroundColor: Colors.blue[900],
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )
        ),

        //bottom navigation bar theme
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 0, 90, 255),
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,
        ),

        // elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[900],
          )
        )
      ),
      
      home: MainPage(),
    );
  }
}