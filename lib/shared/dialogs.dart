import 'package:flutter/material.dart';

import '../localization.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog({
    super.key,
    required this.title,
    required this.confirmButtonText,
    required this.onConfirm,
    required this.onCancel,
  });

  final String title;
  final String confirmButtonText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
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
          onPressed: onCancel,
          child: Text(l10n.cancelButtonText),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmButtonText),
        ),
      ],
    );
  }
}
