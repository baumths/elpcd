import 'package:flutter/material.dart';

import 'package:elpcd_dart/src/core/app.dart';

abstract class ShowSnackBar {
  static error(BuildContext context, String msg, {int duration = 3}) {
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

  static info(BuildContext context, String msg, {int duration = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        backgroundColor: AppTheme.accentColor,
        content: Text(
          msg,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
