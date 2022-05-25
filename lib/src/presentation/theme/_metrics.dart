part of 'theme.dart';

const Duration kAnimationDuration = Duration(milliseconds: 250);

const double kmSplashRadius = 20.0;

abstract class AppBorderRadius {
  static const double radiusValue = 12.0;

  static const Radius radius = Radius.circular(radiusValue);

  static const BorderRadius all = BorderRadius.all(radius);

  static const BorderRadius top = BorderRadius.vertical(top: radius);
  static const BorderRadius topLeft = BorderRadius.only(topLeft: radius);
  static const BorderRadius topRight = BorderRadius.only(topRight: radius);
  static const BorderRadius bottom = BorderRadius.vertical(bottom: radius);
  static const BorderRadius bottomLeft = BorderRadius.only(bottomLeft: radius);
  static const BorderRadius bottomRight = BorderRadius.only(bottomRight: radius);

  static const BorderRadius left = BorderRadius.horizontal(left: radius);
  static const BorderRadius right = BorderRadius.horizontal(right: radius);
}

abstract class AppInsets {
  static const double xSmall = 4;
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
}