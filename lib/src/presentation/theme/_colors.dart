part of 'theme.dart';

abstract class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFE6E6E6);

  static const Color primary = Color(0xFF00041A);
  static const Color primaryDarker = Color(0xFF00030F);

  static const Color secondary = Color(0xFF31344B);
  static const Color secondaryVariant = Color(0xFF202231);

  static const Color info = Color(0xFF0156B3);
  static const Color success = Color(0xFF29634B);
  static const Color warning = Color(0xFFF0B53C);
  static const Color danger = Color(0xFFB00020);
}

const ColorScheme kColorScheme = ColorScheme.light(
  onPrimary: AppColors.white,
  primary: AppColors.primary,
  primaryVariant: AppColors.primaryDarker,
  background: AppColors.background,
  onBackground: AppColors.primary,
  onError: AppColors.primary,
  error: AppColors.danger,
  surface: AppColors.white,
  onSurface: AppColors.primary,
  onSecondary: AppColors.primary,
  secondary: AppColors.secondary,
  secondaryVariant: AppColors.secondaryVariant,
);