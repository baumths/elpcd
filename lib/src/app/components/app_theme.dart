import 'package:flutter/material.dart';

abstract class AppTheme {
  static final primaryColor = Colors.indigo;
  static final accentColor = Colors.orange;

  static ThemeData themeData(bool darkMode) {
    return ThemeData(
      primarySwatch: AppTheme.primaryColor,
      accentColor: AppTheme.accentColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: darkMode ? Brightness.dark : Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2),
        ),
      ),
      hoverColor: darkMode
          ? Colors.white.withOpacity(0.15)
          : Colors.grey.withOpacity(0.5),
    );
  }
}
