import 'package:flutter/material.dart';

part '_colors.dart';
part '_metrics.dart';

final ThemeData kLightTheme = ThemeData(
  colorScheme: kColorScheme,
  errorColor: AppColors.danger,
  tooltipTheme: tooltipTheme,
  navigationRailTheme: navigationRailTheme,
);

final TooltipThemeData tooltipTheme = TooltipThemeData(
  padding: const EdgeInsets.all(AppEdgeInsets.small),
  textStyle: TextStyle(color: kColorScheme.onPrimary, fontSize: 12),
  decoration: BoxDecoration(
    color: kColorScheme.primary.withOpacity(.9),
    borderRadius: AppBorderRadius.all,
  ),
);

NavigationRailThemeData get navigationRailTheme {
  final Color selectedColor = kColorScheme.onPrimary;
  final Color unselectedColor = kColorScheme.onPrimary.withOpacity(.4);
  const double iconSize = 32.0;

  return NavigationRailThemeData(
    backgroundColor: kColorScheme.primary,
    selectedIconTheme: IconThemeData(
      color: selectedColor,
      size: iconSize,
    ),
    unselectedIconTheme: IconThemeData(
      color: unselectedColor,
      size: iconSize,
    ),
    selectedLabelTextStyle: TextStyle(
      color: selectedColor,
    ),
    unselectedLabelTextStyle: TextStyle(
      color: unselectedColor,
    ),
  );
}
