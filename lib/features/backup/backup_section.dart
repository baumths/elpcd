import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localization.dart';
import '../../repositories/classes_repository.dart';
import '../../shared/show_snackbar.dart';
import '../settings/settings_controller.dart';
import 'backup_service.dart';

class BackupSection extends StatelessWidget {
  const BackupSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(l10n.backupSectionTitle),
          trailing: Tooltip(
            message: l10n.wipFeatureTooltipMessage,
            child: const Badge(
              label: Text(
                'WIP',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.tonal(
                  child: Text(l10n.importButtonText),
                  onPressed: () => import(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonal(
                  child: Text(l10n.exportButtonText),
                  onPressed: () => export(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> import(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final classesRepository = context.read<ClassesRepository>();
    final settingsController = context.read<SettingsController>();

    final XFile? file = await openFile(
      acceptedTypeGroups: const <XTypeGroup>[
        XTypeGroup(label: 'JSON', extensions: <String>['json']),
      ],
    );

    if (file == null) return;

    final json = await file.readAsString();

    String? errorMessage;

    try {
      await BackupService.importFromJson(
        json: json,
        classesRepository: classesRepository,
        settingsController: settingsController,
      );

      if (context.mounted) {
        ShowSnackBar.info(
          context,
          l10n.backupSuccessfullyImportedSnackbarText,
          duration: 5,
        );
      }
    } on FormatException {
      errorMessage = l10n.backupImportFormatExceptionText;
    } on BackupException {
      errorMessage = l10n.backupImportFailureText;
    } finally {
      if (context.mounted) {
        if (errorMessage != null) {
          ShowSnackBar.error(context, errorMessage, duration: 5);
        }
        Scaffold.maybeOf(context)?.closeDrawer();
      }
    }
  }

  Future<void> export(BuildContext context) async {
    await BackupService.exportToJson(
      settingsController: context.read<SettingsController>(),
      classesRepository: context.read<ClassesRepository>(),
    );
    if (context.mounted) {
      ShowSnackBar.info(
        context,
        AppLocalizations.of(context).backupSuccessfullyExportedSnackbarText,
      );
      Scaffold.maybeOf(context)?.closeDrawer();
    }
  }
}
