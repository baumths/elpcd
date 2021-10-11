import 'package:flutter/material.dart';

part '_colors.dart';
part '_metrics.dart';

final ThemeData kLightTheme = ThemeData(
  colorScheme: kColorScheme,
  errorColor: AppColors.danger,
  dividerTheme: dividerTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  navigationRailTheme: navigationRailTheme,
  tooltipTheme: tooltipTheme,
  hoverColor: AppColors.primary15,
);

const DividerThemeData dividerTheme = DividerThemeData(
  color: AppColors.primaryLight,
  space: 1.5,
  thickness: 1.5,
);

final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    primary: kColorScheme.primary,
    onPrimary: kColorScheme.onPrimary,
    onSurface: kColorScheme.onSurface,
    shape: const RoundedRectangleBorder(
      borderRadius: AppBorderRadius.all,
    ),
  ),
);

NavigationRailThemeData get navigationRailTheme {
  final Color selectedColor = kColorScheme.onPrimary;
  const Color unselectedColor = AppColors.primaryLight;
  const double iconSize = 32.0;

  return NavigationRailThemeData(
    backgroundColor: kColorScheme.primary,
    selectedIconTheme: IconThemeData(
      color: selectedColor,
      size: iconSize,
    ),
    unselectedIconTheme: const IconThemeData(
      color: unselectedColor,
      size: iconSize,
    ),
    selectedLabelTextStyle: TextStyle(
      color: selectedColor,
    ),
    unselectedLabelTextStyle: const TextStyle(
      color: unselectedColor,
    ),
  );
}

final TooltipThemeData tooltipTheme = TooltipThemeData(
  padding: const EdgeInsets.all(AppInsets.small),
  textStyle: TextStyle(color: kColorScheme.onPrimary, fontSize: 12),
  decoration: BoxDecoration(
    color: kColorScheme.primary.withOpacity(.9),
    borderRadius: AppBorderRadius.all,
  ),
);
