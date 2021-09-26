import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

export 'dart:ui' show lerpDouble;

mixin AnimatedStateMixin<T extends StatefulWidget>
    on State<T>, SingleTickerProviderStateMixin<T> {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  AnimationController get animationController => _controller;
  Animation<double> get animation => _animation;

  /// Classes that mixin this can override [curve].
  Curve get curve => Curves.ease;

  /// Classes that mixin this can override [duration].
  Duration get duration => kAnimationDuration;

  @mustCallSuper
  TickerFuture animateForward({double? from}) {
    return _controller.forward(from: from);
  }

  @mustCallSuper
  TickerFuture animateReverse({double? from}) {
    return _controller.reverse(from: from);
  }

  @override
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _animation = CurvedAnimation(parent: _controller, curve: curve);
  }

  @override
  @protected
  @mustCallSuper
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

abstract class AnimatedState<T extends StatefulWidget> = State<T>
    with SingleTickerProviderStateMixin<T>, AnimatedStateMixin<T>;
