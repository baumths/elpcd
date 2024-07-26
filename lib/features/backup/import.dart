import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/show_snackbar.dart';
import '../settings/settings_controller.dart';
import 'backup_service.dart';

class BackupImportTile extends StatelessWidget {
  const BackupImportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Importar Backup JSON'),
      trailing: const Icon(Icons.upload),
      onTap: () async {
        final settingsController = context.read<SettingsController>();

        final XFile? file = await openFile(
          acceptedTypeGroups: const <XTypeGroup>[
            XTypeGroup(label: 'JSON', extensions: <String>['json']),
          ],
        );

        if (file == null) return;

        final json = await file.readAsString();

        try {
          await BackupService.importFromJson(
            json: json,
            settingsController: settingsController,
          );

          if (context.mounted) {
            ShowSnackBar.info(context, 'Backup importado com sucesso');
            Scaffold.maybeOf(context)?.closeDrawer();
          }
        } on BackupException catch (e) {
          if (context.mounted) {
            ShowSnackBar.error(
              context,
              e.message,
              duration: 10,
            );
            Scaffold.maybeOf(context)?.closeDrawer();
          }
        }
      },
    );
  }
}
