import 'package:flutter/material.dart';

import 'shared.dart';

abstract class AppDialogs {
  static Widget warning({
    BuildContext context,
    String title,
    String btnText,
  }) {
    return AlertDialog(
      elevation: 12,
      title: Text(title, textAlign: TextAlign.center).center(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
      content: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlineButton(
            borderSide: BorderSide.none,
            child: const Text('Cancelar'),
            onPressed: () => context.pop<bool>(false),
          ),
          Tooltip(
            message: 'Impossível desfazer',
            child: RaisedButton(
              color: Colors.redAccent.shade700,
              textTheme: ButtonTextTheme.primary,
              child: Text(
                btnText.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () => context.pop<bool>(true),
            ),
          ),
        ],
      ),
    );
  }
}
