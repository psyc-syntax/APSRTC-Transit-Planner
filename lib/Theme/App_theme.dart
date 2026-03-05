import 'package:flutter/material.dart';

const kLightColorScheme = ColorScheme(
  brightness: Brightness.light, 
  primary: Color(0xFFF97316), 
  onPrimary: Colors.white, 
  secondary: Color(0xFF2562EB), 
  onSecondary: Colors.white, 
  error: Color(0xFFDC2626), 
  onError: Colors.white, 
  surface: Colors.white, 
  onSurface: Color(0xFF0F172A),
);

const kDarkColorScheme = ColorScheme(
  brightness: Brightness.dark, 
  primary: Color(0xFFF97316), 
  onPrimary: Colors.white, 
  secondary: Color(0xFF60A5FA), 
  onSecondary: Colors.black, 
  error: Color(0xffef4444), 
  onError: Colors.black, 
  surface: Color(0xff1e293b), 
  onSurface: Colors.white,
);

class AppTheme{

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: kLightColorScheme,
    scaffoldBackgroundColor: kLightColorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: kLightColorScheme.surface,
      elevation: 0,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: kLightColorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      )
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kLightColorScheme.primary,
        foregroundColor: kLightColorScheme.onPrimary,
      )
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kLightColorScheme.surface,
      selectedItemColor: kLightColorScheme.primary,
    )
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: kDarkColorScheme,
    scaffoldBackgroundColor: kDarkColorScheme.surface,

    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.transparent,
      foregroundColor: kDarkColorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: kDarkColorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      )
    ),


    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kDarkColorScheme.primary,
        foregroundColor: kDarkColorScheme.onPrimary,
      )
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kDarkColorScheme.surface,
      selectedItemColor: kDarkColorScheme.primary,
    )

    
  );
}

