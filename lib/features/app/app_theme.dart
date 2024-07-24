import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData themeData({bool darkMode = true}) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF7287FD),
        brightness: darkMode ? Brightness.dark : Brightness.light,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
