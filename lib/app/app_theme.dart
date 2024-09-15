import 'package:flutter/material.dart';

ThemeData createAppThemeWithBrightness(Brightness brightness) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: const Color(0xFF7287FD),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
