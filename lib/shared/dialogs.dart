import 'package:flutter/material.dart';

import '../localization.dart';

abstract class AppDialogs {
  static Widget warning({
    required BuildContext context,
    required String title,
    required String btnText,
  }) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsOverflowButtonSpacing: 8,
      title: Text(title),
      content: Text(l10n.actionCannotBeUndoneWarning),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop<bool>(false),
          child: Text(l10n.cancelButtonText),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop<bool>(true),
          child: Text(btnText),
        ),
      ],
    );
  }
}
