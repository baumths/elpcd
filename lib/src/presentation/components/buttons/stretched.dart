import 'package:flutter/material.dart';

class StretchedButton extends StatelessWidget {
  const StretchedButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.height,
  }) : super(key: key);

  final Widget child;

  final double? height;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          elevation: 0,
        ),
      ),
    );
  }
}
