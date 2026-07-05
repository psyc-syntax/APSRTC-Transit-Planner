import 'package:flutter/material.dart';


const kLightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Brand orange
  // Used for:
  // Main buttons
  // Active icons
  // Highlights
  primary: Color(0xFFF97316),
  onPrimary: Colors.white,

  // Accent blue
  // Used for:
  // Secondary actions
  // Special highlights
  secondary: Colors.lightBlueAccent,
  onSecondary: Colors.white,

  // Error color
  // Used for:
  // Failed actions
  // Validation errors
  error: Color(0xFFDC2626),
  onError: Colors.white,

  // Main app background
  // Whole screen background color
  surface: Color(0xFFF8FAFC),

  // Primary text color
  // Main  text color in light mode
  onSurface: Color(0xFF0F172A),

  // Slightly faded text color
  // Used for subtitles and helper text
  onSurfaceVariant: Color(0xFF64748B),

  // Card colors
  // White cards on white background gives clean modern look
  surfaceContainerHighest: Colors.white,
  surfaceContainerHigh: Color(0xFFF1F5F9),
  secondaryContainer: Colors.white,
);

/// 
/// DARK COLOR SCHEME
/// 
///
/// Dark mode colors
///
const kDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // orange -- primary color
  primary: Color(0xFFF97316),
  onPrimary: Colors.white,

  // Accent blue
  secondary: Color(0xFF60A5FA),
  onSecondary: Colors.black,

  // Error color
  error: Color(0xffef4444),
  onError: Colors.black,

  // Main dark background
  // deep navy dark look from UI design
  surface: Color(0xFF0F1C2E),

  // Main  text
  onSurface: Colors.white,

  // Soft secondary text
  onSurfaceVariant: Colors.white70,

  // Main card color
  // Slightly lighter than scaffold background
  surfaceContainerHighest: Color(0xFF16273D),

  // Elevated cards
  // Used when a card needs more visual importance
  surfaceContainerHigh: Color(0xFF1B2F4A),

  secondaryContainer: Color(0xFFFAF9F6),
);

class AppTheme {

  /// 
  /// LIGHT THEME
  /// 
  static final lightTheme = ThemeData(
    useMaterial3: true,

    colorScheme: kLightColorScheme,

    // Overall app background
    scaffoldBackgroundColor: kLightColorScheme.surface,

    // Divider lines between widgets/cards
    dividerColor: const Color(0xFFE2E8F0),

    /// 
    /// APP BAR
    /// 
    ///
    /// Transparent appbar
    ///
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: kLightColorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
    ),

    /// 
    /// CARD DESIGN
    /// 
    ///
    /// Used for:
    /// - Route cards
    /// - Trip cards
    /// - Stop list items
    /// - Smart insight section
    ///
    cardTheme: CardThemeData(
      color: kLightColorScheme.surfaceContainerHighest,
      elevation: 1,

      // Rounded corners exactly like your design
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    /// 
    /// ELEVATED BUTTONS
    /// 
    ///
    /// Used for:
    /// PLAN SMART TRIP
    /// START NAVIGATION
    /// CONFIRM & CONTINUE
    ///
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kLightColorScheme.primary,
        foregroundColor: kLightColorScheme.onPrimary,

        // Smooth rounded buttons
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),

    /// 
    /// BOTTOM NAVIGATION BAR
    /// 
    ///
    /// Used for:
    /// Home
    /// Stops
    /// Trips
    /// More
    ///
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kLightColorScheme.surfaceContainerHighest,

      // Active tab color
      selectedItemColor: kLightColorScheme.primary,

      // Inactive tab color
      unselectedItemColor: kLightColorScheme.onSurfaceVariant,
    ),

    /// 
    /// TEXT THEME
    /// 
    /// 
    textTheme: const TextTheme(

      /// 
      /// SCREEN TITLES
      /// 
      ///
      /// Biggest text style in the app.
      ///
      /// Used for:
      /// Trip Details
      /// Select Stop
      /// Saved Trips
      /// AppBar screen titles
      ///
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,

        // Slightly tighter spacing
        letterSpacing: -0.2,

        color: Color(0xFF0F172A),
      ),

      /// 
      /// SECTION HEADINGS
      /// 
      ///
      /// inside pages to separate sections.
      ///
      /// used for:
      /// - Smart Insight
      /// - Trip Notes
      /// - Recent Searches
      /// - Nearby Stops
      ///
      titleLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
      ),

      /// 
      /// MAIN CARD TITLES
      /// 
      ///
      /// This is one of the most used styles.
      ///
      /// Used for:
      /// City names
      /// Stop names
      /// Route names
      /// Trip names
      ///
      /// Example:
      /// Bhadrachalam
      /// Vijayawada
      /// Nellore
      ///
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,

        // Better line spacing for multi-line text
        height: 1.2,

        color: Color(0xFF0F172A),
      ),

      /// 
      /// SMALL LABELS
      /// 
      ///
      /// Small informative labels.
      ///
      /// Used for:
      /// - Travel Date
      /// - Total Distance
      /// - Total Time
      /// - Stops
      /// - Route Overview
      ///
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,

        // Small spacing makes labels look cleaner
        letterSpacing: 0.5,

        color: Color(0xFF64748B),
      ),

      /// 
      /// IMPORTANT CONTENT TEXT
      /// 
      ///
      /// Used where text should stand out
      /// but not as much as titles.
      ///
      /// Used for:
      /// - Timings
      /// - Important route details
      /// - Main content inside cards
      /// - Schedule information
      ///
      bodyLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: Color(0xFF0F172A),
      ),

      /// 
      /// NORMAL DESCRIPTION TEXT
      /// 
      ///
      /// Most commonly used readable text style.
      ///
      /// Used for:
      /// - Descriptions
      /// - Trip notes
      /// - Addresses
      /// - Settings subtitles
      /// - Information paragraphs
      ///
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,

        // Better readability
        height: 1.5,

        color: Color(0xFF475569),
      ),

      /// 
      /// SMALL SUPPORTING TEXT
      /// 
      ///
      /// Lowest priority text.
      ///
      /// Used for:
      /// - km values
      /// - timestamps
      /// - halt durations
      /// - helper text
      /// - tiny metadata
      ///
      bodySmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: Color(0xFF94A3B8),
      ),

      /// 
      /// BUTTON TEXT
      /// 
      ///
      /// Used only inside buttons.
      ///
      /// Examples:
      /// - PLAN SMART TRIP
      /// - START NAVIGATION
      /// - SAVE TRIP
      ///
      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,

        // Slight spacing gives modern button feel
        letterSpacing: 0.3,

        color: Colors.white,
      ),

      /// 
      /// BOTTOM NAV LABELS
      /// 
      ///
      /// Used below bottom navigation icons.
      ///
      /// Examples:
      /// - Plan
      /// - Stops
      /// - Trips
      /// - More
      ///
      labelMedium: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color(0xFF64748B),
      ),
    ),
  );

  /// 
  /// DARK THEME
  /// 
  static final darkTheme = ThemeData(
    useMaterial3: true,

    colorScheme: kDarkColorScheme,

    scaffoldBackgroundColor: kDarkColorScheme.surface,

    dividerColor: const Color(0xFF334155),

    /// 
    /// APP BAR
    /// 
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: kDarkColorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
    ),

    /// 
    /// CARD DESIGN
    /// 
    ///
    /// Dark cards are slightly lighter than background
    /// so they separate naturally.
    ///
    cardTheme: CardThemeData(
      color: kDarkColorScheme.surfaceContainerHighest,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    /// 
    /// ELEVATED BUTTONS
    /// 
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kDarkColorScheme.primary,
        foregroundColor: kDarkColorScheme.onPrimary,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),

    /// 
    /// BOTTOM NAVIGATION BAR
    /// 
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kDarkColorScheme.surface,
      selectedItemColor: kDarkColorScheme.primary,
      unselectedItemColor: const Color(0xFFCBD5E1),
    ),

    /// 
    /// DARK TEXT THEME
    /// 
    textTheme: const TextTheme(

      // Main screen titles
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        color: Color(0xFFF8FAFC),
      ),

      // Section titles inside screens
      titleLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: Color(0xFFF8FAFC),
      ),

      // Main content titles
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: Color(0xFFE2E8F0),
      ),

      // Small labels
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
        color: Color(0xFF94A3B8),
      ),

      // Important readable text
      bodyLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: Color(0xFFF8FAFC),
      ),

      // Normal body text
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: Color(0xFFCBD5E1),
      ),

      // Tiny metadata text
      bodySmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: Color(0xFF94A3B8),
      ),

      // Button text
      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
        color: Colors.white,
      ),

      // Bottom nav labels
      labelMedium: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color(0xFFCBD5E1),
      ),
    ),
  );
}