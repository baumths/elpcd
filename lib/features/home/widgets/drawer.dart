import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../repositories/hive_repository.dart';
import '../../../shared/csv_export.dart';
import '../../backup/export.dart';
import '../../backup/import.dart';
import '../home_controller.dart';
import 'codearq_editor.dart';

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
                const _ChangeCodearqTile(),
                const _DarkModeSwitch(),
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

        //! Convert CsvExport into a bloc to show progress in UI
        await CsvExport(repository).downloadCsvFile();

        homeController.toggleSaving(value: false);
      },
    );
  }
}

class _ChangeCodearqTile extends StatelessWidget {
  const _ChangeCodearqTile();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final repository = RepositoryProvider.of<HiveRepository>(context);
    return ListTile(
      title: const Text('Editar CODEARQ'),
      trailing: Badge(
        largeSize: 32,
        textColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        label: ValueListenableBuilder(
          valueListenable: repository.listenToSettings(keys: ['codearq']),
          builder: (_, __, ___) {
            var codearq = repository.codearq;
            if (codearq.length > 9) {
              codearq = '${codearq.substring(0, 10)}...';
            }
            return Text(codearq);
          },
        ),
      ),
      onTap: () {
        Navigator.of(context).pop(); // Close drawer
        showModalBottomSheet(
          context: context,
          builder: (_) => const CodearqEditor(),
        );
      },
    );
  }
}

class _DarkModeSwitch extends StatelessWidget {
  const _DarkModeSwitch();

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<HiveRepository>(context);
    return SwitchListTile(
      title: const Text('Modo Noturno'),
      value: repository.isDarkMode,
      onChanged: (value) async {
        final homeController = context.read<HomeController>()
          ..toggleSaving(value: true);

        await HiveRepository.settingsBox.put('darkMode', value);

        homeController.toggleSaving(value: false);
      },
    );
  }
}
