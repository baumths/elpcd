import 'package:flutter/material.dart';

part '_colors.dart';
part '_metrics.dart';

final ThemeData kLightTheme = ThemeData(
  colorScheme: kColorScheme,
  errorColor: AppColors.danger,
  tooltipTheme: tooltipTheme,
  navigationRailTheme: navigationRailTheme,
  dividerTheme: dividerTheme,
  hoverColor: AppColors.primary15,
);

const DividerThemeData dividerTheme = DividerThemeData(
  color: AppColors.primaryLight,
  space: 1.5,
  thickness: 1.5,
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
