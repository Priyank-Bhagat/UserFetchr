import 'package:flutter/material.dart';

class AppTheme {
  static const Color accentColor = Color(0xFF00ADB5);

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF222831);
  static const Color darkSurface = Color(0xFF393E46);
  static const Color darkTextColor = Color(0xFFEEEEEE);
  static const Color darkHintColor = Colors.white54;

  // Light Mode Colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightTextColor = Color(0xFF222831);
  static const Color lightHintColor = Color(0xFF666666);
  static const Color lightSubtleTextColor = Color(0xFF444444);

  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: darkBackground,
      primaryColor: accentColor,
      colorScheme: base.colorScheme.copyWith(
        brightness: Brightness.dark,
        background: darkBackground,
        surface: darkSurface,
        primary: accentColor,
        secondary: accentColor,
        onPrimary: darkTextColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: darkTextColor,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: darkTextColor,
        displayColor: darkTextColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        hintStyle: const TextStyle(color: darkHintColor),
        prefixIconColor: accentColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      iconTheme: const IconThemeData(color: accentColor),
    );
  }

  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: lightBackground,
      primaryColor: accentColor,
      colorScheme: base.colorScheme.copyWith(
        brightness: Brightness.light,
        background: lightBackground,
        surface: lightSurface,
        primary: accentColor,
        secondary: accentColor,
        onPrimary: lightTextColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: lightTextColor,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: base.textTheme.copyWith(
        bodyMedium: const TextStyle(color: lightSubtleTextColor),
        bodySmall: const TextStyle(color: lightHintColor),
        titleMedium: const TextStyle(color: lightTextColor),
        titleLarge: const TextStyle(color: lightTextColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurface,
        hintStyle: const TextStyle(color: lightHintColor),
        prefixIconColor: accentColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      iconTheme: const IconThemeData(color: accentColor),
    );
  }
}
