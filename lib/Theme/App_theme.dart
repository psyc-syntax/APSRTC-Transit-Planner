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
  secondaryContainer: Colors.white,
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
  secondaryContainer: Color(0xFFFAF9F6),
  
);

class AppTheme{

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: kLightColorScheme,
    scaffoldBackgroundColor: kLightColorScheme.surface,
    dividerColor: const Color(0xFFE2E8F0),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: kLightColorScheme.onSurface,
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
    ),

    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),

      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
        letterSpacing: 2,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,

      ),

      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      )


    )
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: kDarkColorScheme,
    scaffoldBackgroundColor: kDarkColorScheme.surface,
    dividerColor: const Color(0xFF334155),

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
    ),

    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),

      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(205, 255, 255, 255)
      ),

      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),

      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
        letterSpacing: 2,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,

      ),

      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      )
    )

    
  );
}

