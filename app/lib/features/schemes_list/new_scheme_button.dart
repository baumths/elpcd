import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_service/storage_service.dart';

import '../app/router.dart';
import '/localizations.dart';

class NewSchemeButton extends StatelessWidget {
  const NewSchemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      child: Text(context.l10n.newScheme),
      onPressed: () {
        // TODO(chore): move scheme creation to a more appropriated place
        final scheme = Class.empty();
        // unawaited so navigation happens immediately
        context.read<ClassesRepository>().save(scheme);
        AppRouter.goToSchemeExplorer(context, scheme);
      },
    );
  }
}
