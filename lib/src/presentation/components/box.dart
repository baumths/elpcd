import 'package:flutter/material.dart';

import '../theme/theme.dart';

class Box extends StatelessWidget {
  const Box({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.decoration,
  }) : super(key: key);

  final Widget? child;

  final double? width;

  final double? height;

  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    Widget? _child;

    if (decoration != null) {
      _child = DecoratedBox(
        decoration: decoration!,
        child: child,
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: _child ?? child,
    );
  }
}

// TODO: Convert to simple animation controller so we only show the child when animation completes

class AnimatedBox extends ImplicitlyAnimatedWidget {
  const AnimatedBox({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.decoration,
    Curve curve = Curves.ease,
    Duration duration = kAnimationDuration,
    VoidCallback? onEnd,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final Widget? child;

  final Decoration? decoration;

  final double? width;

  final double? height;

  @override
  AnimatedWidgetBaseState<AnimatedBox> createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends AnimatedWidgetBaseState<AnimatedBox> {
  DecorationTween? _decoration;
  Tween<double>? _width;
  Tween<double>? _height;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _decoration = visitor(
      _decoration,
      widget.decoration,
      (dynamic value) => DecorationTween(begin: value as Decoration),
    ) as DecorationTween?;

    _width = visitor(
      _width,
      widget.width,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;

    _height = visitor(
      _height,
      widget.height,
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    return Box(
      decoration: _decoration?.evaluate(animation),
      width: _width?.evaluate(animation),
      height: _height?.evaluate(animation),
      child: widget.child,
    );
  }
}
