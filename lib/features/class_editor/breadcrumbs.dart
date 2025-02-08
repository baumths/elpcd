import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../settings/settings_controller.dart';
import 'class_editor.dart';
import 'earq_brasil_metadata.dart';

class ClassEditorBreadcrumbs extends StatelessWidget {
  const ClassEditorBreadcrumbs({super.key});

  static const Widget separator = Icon(LucideIcons.chevronRight, size: 20);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final editor = context.read<ClassEditor>();

    final subordination = editor.valueOf(EarqBrasilMetadata.subordinacao);
    if (subordination == null || subordination.isEmpty) {
      return const SizedBox.shrink();
    }

    final institutionCode = context.select<SettingsController, String>(
      (settings) => settings.institutionCode,
    );

    final breadcrumbs = subordination.split('-');

    final code = context.select<ClassEditor, String?>(
      (editor) => editor.valueOf(EarqBrasilMetadata.codigo),
    );

    return DefaultTextStyle(
      style: theme.textTheme.titleSmall!,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Text(institutionCode),
            separator,
            for (int index = 0; index < breadcrumbs.length * 2 - 1; index++)
              index.isEven ? Text(breadcrumbs[index ~/ 2]) : separator,
            if (code != null && code.isNotEmpty) ...[
              separator,
              Text(
                code,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
