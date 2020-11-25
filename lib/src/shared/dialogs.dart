import 'package:flutter/material.dart';

abstract class AppDialogs {
  static Widget warning({
    BuildContext context,
    String title,
    String btnText,
  }) {
    final cancelTextColor = Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).accentColor
        : Theme.of(context).primaryColor;
    return AlertDialog(
      elevation: 12,
      title: Center(child: Text(title, textAlign: TextAlign.center)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 4),
      content: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlineButton(
            textColor: cancelTextColor,
            borderSide: BorderSide.none,
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop<bool>(false),
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
              onPressed: () => Navigator.of(context).pop<bool>(true),
            ),
          ),
        ],
      ),
    );
  }
}
