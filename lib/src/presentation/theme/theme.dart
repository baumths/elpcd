import 'package:flutter/material.dart';

part '_colors.dart';
part '_metrics.dart';

final ThemeData kLightTheme = ThemeData(
  colorScheme: kColorScheme,
  errorColor: AppColors.danger,
  tooltipTheme: TooltipThemeData(
    padding: const EdgeInsets.all(10),
    textStyle: TextStyle(color: kColorScheme.onPrimary, fontSize: 12),
    decoration: BoxDecoration(
      color: kColorScheme.primary.withOpacity(.9),
      borderRadius: AppBorderRadius.all,
    ),
  ),
);
