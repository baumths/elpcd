import 'package:flutter/material.dart';

import '../shared/shared.dart';

abstract class ShowSnackBar {
  static void error(BuildContext context, String msg, {int duration = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        backgroundColor: Colors.red[900],
        content: Text(
          msg,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static void info(BuildContext context, String msg, {int duration = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        backgroundColor: context.accentColor,
        content: Text(
          msg,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
