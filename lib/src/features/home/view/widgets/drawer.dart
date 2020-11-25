import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/hive_repository.dart';
import '../../../../shared/shared.dart';
import '../../home.dart';
import 'widgets.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key key}) : super(key: key);

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
                if (isSaving) const LinearProgressIndicator(),
                const _DownloadCsvTile(),
                const _ChangeCodearqTile(),
                const _DarkModeSwitch(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DrawerHeader(
      child: SizedBox.shrink(),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/gedalogo_270x270.png'),
        ),
      ),
    );
  }
}

class _DownloadCsvTile extends StatelessWidget {
  const _DownloadCsvTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<HiveRepository>(context);
    return ListTile(
      title: const Text('Download CSV'),
      trailing: const Icon(Icons.file_download),
      onTap: () async {
        context.read<HomeController>().toggleSaving(value: true);

        //! Convert CsvExport into a bloc to show progress in UI
        await CsvExport(repository).downloadCsvFile();

        context.read<HomeController>().toggleSaving(value: false);
      },
    );
  }
}

class _ChangeCodearqTile extends StatelessWidget {
  const _ChangeCodearqTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<HiveRepository>(context);
    return ListTile(
      title: const Text('Editar CODEARQ'),
      trailing: Chip(
        label: ValueListenableBuilder(
          valueListenable: repository.listenToSettings(keys: ['codearq']),
          builder: (_, __, ___) {
            var codearq = repository.codearq;
            if (codearq.length > 9) {
              codearq = '${codearq.substring(0, 10)}...';
            }
            return Text(
              codearq,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            );
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
  const _DarkModeSwitch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<HiveRepository>(context);
    return SwitchListTile(
      title: const Text('Modo Noturno'),
      activeColor: Theme.of(context).accentColor,
      value: repository.isDarkMode,
      onChanged: (_) async {
        final homeController = context.read<HomeController>()
          ..toggleSaving(value: true);

        // TODO: Move to HomeBloc
        await HiveRepository.settingsBox.put('darkMode', _);

        homeController.toggleSaving(value: false);
      },
    );
  }
}
