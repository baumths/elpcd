import 'package:flutter/material.dart';

import '../../shared/show_snackbar.dart';
import 'backup_service.dart';

class BackupExportTile extends StatelessWidget {
  const BackupExportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Exportar Backup JSON'),
      trailing: const Icon(Icons.download),
      onTap: () async {
        await BackupService.exportToJson();
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
