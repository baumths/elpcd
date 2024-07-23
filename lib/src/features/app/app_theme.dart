import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData themeData({bool darkMode = true}) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue.shade900,
        brightness: darkMode ? Brightness.dark : Brightness.light,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 2),
        ),
      ),
      hoverColor: darkMode
          ? Colors.white.withOpacity(0.15)
          : Colors.grey.withOpacity(0.5),
    );
  }
}
