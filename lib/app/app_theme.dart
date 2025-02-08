import 'package:flutter/material.dart';

const rectangleShape = RoundedRectangleBorder(borderRadius: BorderRadius.zero);
const roundedRectangleShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(6)),
);

ThemeData createAppThemeWithBrightness(Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: const Color(0xFF7287FD),
  );
  final borderSide = BorderSide(color: colorScheme.outlineVariant);

  return ThemeData(
    colorScheme: colorScheme,
    fontFamily: 'Inter',
    cardTheme: CardThemeData(
      elevation: 0,
      shape: roundedRectangleShape.copyWith(side: borderSide),
    ),
    dialogTheme: const DialogThemeData(shape: roundedRectangleShape),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: colorScheme.outlineVariant,
      thickness: 1,
      space: 8,
    ),
    drawerTheme: const DrawerThemeData(shape: rectangleShape),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: roundedRectangleShape,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        shape: roundedRectangleShape,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    menuButtonTheme: MenuButtonThemeData(
      style: MenuItemButton.styleFrom(
        iconSize: 20,
        shape: roundedRectangleShape,
        visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
      ),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        elevation: const WidgetStatePropertyAll(0.0),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        ),
        shape: const WidgetStatePropertyAll(roundedRectangleShape),
        side: WidgetStatePropertyAll(borderSide),
      ),
    ),
    searchViewTheme: SearchViewThemeData(
      elevation: 0,
      shape: roundedRectangleShape,
      side: borderSide,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: roundedRectangleShape,
      ),
    ),
  );
}
