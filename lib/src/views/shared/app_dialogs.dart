import 'package:flutter/material.dart';

import 'package:elpcd_dart/src/utils/utils.dart';

abstract class AppDialogs {
  static Widget warning({
    BuildContext context,
    String title,
    String btnText,
  }) {
    var btnPadding = const EdgeInsets.symmetric(vertical: 16, horizontal: 24);
    return AlertDialog(
      elevation: 12,
      title: Text(title, textAlign: TextAlign.center).center(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlineButton(
            padding: btnPadding,
            child: const Text('Cancelar'),
            onPressed: () => context.pop<bool>(false),
          ),
          const SizedBox(),
          Tooltip(
            message: 'Impossível desfazer',
            child: RaisedButton(
              color: Colors.red[700],
              padding: btnPadding,
              child: Text(btnText, style: const TextStyle(color: Colors.white)),
              onPressed: () => context.pop<bool>(true),
            ),
          ),
        ],
      ),
    );
  }
}
