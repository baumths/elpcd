import 'package:flutter/material.dart';

abstract class AppDialogs {
  static Widget warning({
    required BuildContext context,
    required String title,
    required String btnText,
  }) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsOverflowButtonSpacing: 8,
      title: Text(title),
      content: const Text('Essa ação não poderá ser desfeita.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop<bool>(false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop<bool>(true),
          child: Text(btnText),
        ),
      ],
    );
  }
}
