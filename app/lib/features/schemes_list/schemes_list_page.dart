import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/localizations.dart';
import '/shared/widgets/elevated_box.dart';
import 'new_scheme_button.dart';
import 'schemes_list.dart';
import 'schemes_list_controller.dart';

class SchemesListPage extends StatelessWidget {
  const SchemesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => SchemesListController(
        entitiesRepository: context.read(),
      )..fetchSchemes(),
      dispose: (_, controller) => controller.dispose(),
      child: const Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
        child: Column(
          children: [
            SchemesListHeader(),
            SizedBox(height: 8),
            Expanded(
              child: ElevatedBox(
                child: SchemesList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SchemesListHeader extends StatelessWidget {
  const SchemesListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            l10n.classificationSchemes,
            style: theme.textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const NewSchemeButton(),
      ],
    );
  }
}
