import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/classes_repository.dart';
import '../../shared/show_snackbar.dart';
import '../settings/settings_controller.dart';
import 'backup_service.dart';

class BackupSection extends StatelessWidget {
  const BackupSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text('Backup JSON'),
          trailing: Tooltip(
            message: 'Funcionalidade em desenvolvimento',
            child: Badge(
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
                  child: const Text('Importar'),
                  onPressed: () => import(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonal(
                  child: const Text('Exportar'),
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
    final classesRepository = context.read<ClassesRepository>();
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
        classesRepository: classesRepository,
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
  }

  Future<void> export(BuildContext context) async {
    await BackupService.exportToJson(
      settingsController: context.read<SettingsController>(),
      classesRepository: context.read<ClassesRepository>(),
    );
    if (context.mounted) {
      ShowSnackBar.info(
        context,
        'O arquivo exportado pode ser importado novamente pelo ElPCD.',
      );
      Scaffold.maybeOf(context)?.closeDrawer();
    }
  }
}
