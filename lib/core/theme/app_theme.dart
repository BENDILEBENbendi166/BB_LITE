// lib/core/theme/app_theme.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppTheme {
  static const Color darkStart = Color(0xFF0A0F1F);
  static const Color darkEnd = Color(0xFF121417);
  static const Color glowBlue = Color(0xFF00C2FF);
  static const Color accentRed = Color(0xFFFF2E45);

  // -------------------------------
  // LIGHT THEME
  // -------------------------------
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Montserrat',
    useMaterial3: true,

    colorScheme: ColorScheme.fromSeed(
      seedColor: glowBlue,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),

    chipTheme: ChipThemeData(
      selectedColor: glowBlue,
      backgroundColor: Colors.grey.shade200,
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  // -------------------------------
  // DARK THEME
  // -------------------------------
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Montserrat',
    useMaterial3: true,

    scaffoldBackgroundColor: darkStart,

    colorScheme: const ColorScheme.dark(
      primary: glowBlue,
      secondary: accentRed,
      surface: darkEnd,
      background: darkStart,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: darkEnd,
      elevation: 0,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: glowBlue,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkEnd.withOpacity(0.6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),

    chipTheme: ChipThemeData(
      selectedColor: glowBlue,
      backgroundColor: darkEnd.withOpacity(0.4),
      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),

    cardTheme: CardThemeData(
      elevation: 3,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
