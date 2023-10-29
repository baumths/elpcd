import 'package:flutter/material.dart';

class ElevatedBox extends StatelessWidget {
  const ElevatedBox({
    super.key,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  });

  final Widget child;

  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final shadowColor = Theme.of(context).colorScheme.shadow;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(.1),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
          BoxShadow(
            color: shadowColor.withOpacity(.08),
            offset: const Offset(0, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: Material(
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}
