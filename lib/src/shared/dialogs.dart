import 'package:flutter/material.dart';

abstract class AppDialogs {
  static Widget warning({
    required BuildContext context,
    required String title,
    required String btnText,
  }) {
    final cancelTextColor = Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).accentColor
        : Theme.of(context).primaryColor;
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
              primary: cancelTextColor,
            ),
            onPressed: () => Navigator.of(context).pop<bool>(false),
            child: const Text('Cancelar'),
          ),
          Tooltip(
            message: 'Impossível desfazer',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent.shade700,
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
