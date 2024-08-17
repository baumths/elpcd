import 'dart:convert' show utf8;

import 'package:file_saver/file_saver.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localization.dart';
import '../../repositories/classes_repository.dart';
import '../../shared/dialogs.dart';
import '../../shared/snackbars.dart';
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
            message: l10n.wipFeatureTooltip,
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

  Future<bool?> showConfirmImportDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return showDialog<bool>(
      context: context,
      builder: (context) => WarningDialog(
        title: l10n.areYouSureDialogTitle,
        content: l10n.confirmImportDialogContent,
        confirmButtonText: l10n.importButtonText,
        onConfirm: () => Navigator.pop(context, true),
        onCancel: () => Navigator.pop(context, false),
      ),
    );
  }

  Future<void> import(BuildContext context) async {
    final confirmed = (await showConfirmImportDialog(context)) ?? false;

    if (!confirmed || !context.mounted) {
      return;
    }

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
        showInfoSnackBar(context, l10n.backupSuccessfullyImportedSnackbarText);
      }
    } on FormatException {
      errorMessage = l10n.backupImportFormatExceptionText;
    } on BackupException {
      errorMessage = l10n.backupImportFailureText;
    } finally {
      if (context.mounted) {
        if (errorMessage != null) {
          showErrorSnackBar(context, errorMessage);
        }
        Scaffold.maybeOf(context)?.closeDrawer();
      }
    }
  }

  Future<void> export(BuildContext context) async {
    final json = BackupService.exportToJson(
      settingsController: context.read<SettingsController>(),
      classesRepository: context.read<ClassesRepository>(),
    );

    await FileSaver.instance.saveFile(
      name: 'elpcd_backup',
      bytes: utf8.encode(json),
      ext: 'json',
      mimeType: MimeType.json,
    );

    if (context.mounted) {
      showInfoSnackBar(
        context,
        AppLocalizations.of(context).backupSuccessfullyExportedSnackbarText,
      );
      Scaffold.maybeOf(context)?.closeDrawer();
    }
  }
}
