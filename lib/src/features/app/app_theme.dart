import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData themeData({bool darkMode = true}) {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue.shade900,
      accentColor: Colors.orange,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: darkMode ? Brightness.dark : Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 2),
        ),
      ),
      hoverColor: darkMode
          ? Colors.white.withOpacity(0.15)
          : Colors.grey.withOpacity(0.5),
    );
  }
}
