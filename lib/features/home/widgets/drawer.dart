import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../repositories/hive_repository.dart';
import '../../../shared/csv_export.dart';
import '../../backup/export.dart';
import '../../backup/import.dart';
import '../../settings/codearq.dart';
import '../../settings/dark_mode.dart';
import '../../settings/settings_controller.dart';
import '../home_controller.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeController, bool>(
      selector: (_, ctrl) => ctrl.isSaving,
      builder: (_, isSaving, __) {
        return Drawer(
          child: IgnorePointer(
            ignoring: isSaving,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const _DrawerHeader(),
                if (isSaving)
                  const LinearProgressIndicator()
                else
                  const SizedBox(height: 4),
                const CodearqListTile(),
                const DarkModeSwitchListTile(),
                const Divider(),
                const _DownloadCsvTile(),
                const Divider(),
                const BackupExportTile(),
                const BackupImportTile(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/gedalogo_270x270.png'),
        ),
      ),
      child: SizedBox.shrink(),
    );
  }
}

class _DownloadCsvTile extends StatelessWidget {
  const _DownloadCsvTile();

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<HiveRepository>(context);
    return ListTile(
      title: const Text('Download CSV'),
      trailing: const Icon(Icons.file_download),
      onTap: () async {
        final homeController = context.read<HomeController>()
          ..toggleSaving(value: true);

        await CsvExport(
          repository,
          codearq: context.read<SettingsController>().codearq,
        ).downloadCsvFile();

        homeController.toggleSaving(value: false);
      },
    );
  }
}
