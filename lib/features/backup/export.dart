import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/classes_repository.dart';
import '../../shared/show_snackbar.dart';
import '../settings/settings_controller.dart';
import 'backup_service.dart';

class BackupExportTile extends StatelessWidget {
  const BackupExportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Exportar Backup JSON'),
      trailing: const Icon(Icons.download),
      onTap: () async {
        await BackupService.exportToJson(
          settingsController: context.read<SettingsController>(),
          classesRepository: context.read<ClassesRepository>(),
        );
        if (context.mounted) {
          ShowSnackBar.info(
            context,
            'O arquivo exportado pode ser importado novamente pelo ElPCD.',
          );
        }
      },
    );
  }
}
