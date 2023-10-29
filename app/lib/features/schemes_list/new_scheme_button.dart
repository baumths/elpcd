import 'package:flutter/material.dart';

import '/localizations.dart';

class NewSchemeButton extends StatelessWidget {
  const NewSchemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      child: Text(context.l10n.newScheme),
      onPressed: () {
        // TODO: show Scheme Explorer
      },
    );
  }
}
