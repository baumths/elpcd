import 'package:flutter/material.dart';

abstract class ShowSnackBar {
  static void error(BuildContext context, String msg, {int duration = 3}) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: duration),
          backgroundColor: theme.colorScheme.error,
          content: Text(
            msg,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onError,
            ),
          ),
        ),
      );
  }

  static void info(BuildContext context, String msg, {int duration = 3}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(seconds: duration),
          content: Text(
            msg,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
  }
}
