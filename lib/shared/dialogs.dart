import 'package:flutter/material.dart';

abstract class AppDialogs {
  static Widget warning({
    required BuildContext context,
    required String title,
    required String btnText,
  }) {
    final theme = Theme.of(context);
    final cancelTextColor = theme.brightness == Brightness.dark
        ? theme.colorScheme.secondary
        : theme.colorScheme.primary;
    return AlertDialog(
      elevation: 12,
      title: Center(
        child: Text(title, textAlign: TextAlign.center),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
      content: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: cancelTextColor,
            ),
            onPressed: () => Navigator.of(context).pop<bool>(false),
            child: const Text('Cancelar'),
          ),
          Tooltip(
            message: 'Impossível desfazer',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
              onPressed: () => Navigator.of(context).pop<bool>(true),
              child: Text(
                btnText.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
