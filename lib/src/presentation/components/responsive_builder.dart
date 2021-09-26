import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  /// Creates a [ResponsiveBuilder].
  ///
  /// Schema:
  ///
  ///`constraints.maxWidth < breakpointSmall`. => [small]
  ///
  ///`constraints.maxWidth > breakpointSmall`. => [medium ?? small]
  ///
  ///`constraints.maxWidth > breakpointMedium`. => [large ?? medium ?? small]
  const ResponsiveBuilder({
    Key? key,
    required this.small,
    this.medium,
    this.large,
    // TODO: Come back and ajust breakpoints once the design is built
    this.breakpointSmall = 516,
    this.breakpointMedium = 900,
    this.animationDuration = const Duration(milliseconds: 250),
  }) : super(key: key);

  final WidgetBuilder small;
  final WidgetBuilder? medium;
  final WidgetBuilder? large;

  final double breakpointSmall;
  final double breakpointMedium;

  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        WidgetBuilder childBuilder = small;

        if (constraints.maxWidth > breakpointSmall) {
          childBuilder = medium ?? small;
        }

        if (constraints.maxWidth > breakpointMedium) {
          childBuilder = large ?? medium ?? small;
        }

        return AnimatedSwitcher(
          duration: animationDuration,
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: childBuilder(context),
        );
      },
    );
  }
}
