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
    final _repository = context.watch<HiveRepository>();
    return Selector<HomeController, bool>(
      selector: (_, ctrl) => ctrl.isSaving,
      builder: (_, isSaving, __) {
        return Drawer(
          child: IgnorePointer(
            ignoring: isSaving,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                // TODO: Make the Logo an CircleAvatar and add social media buttons
                const DrawerHeader(
                  child: SizedBox.shrink(),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/gedalogo_270x270.png'),
                    ),
                  ),
                ),
                if (isSaving) const LinearProgressIndicator(),
                ListTile(
                  title: const Text('Download CSV'),
                  trailing: const Icon(Icons.file_download),
                  onTap: () async {
                    context.read<HomeController>().toggleSaving(value: true);

                    //! Convert CsvExport into a bloc to show progress in UI
                    await CsvExport(_repository).downloadCsvFile();

                    context.read<HomeController>().toggleSaving(value: false);
                  },
                ),
                ListTile(
                  title: const Text('Editar CODEARQ'),
                  trailing: Chip(
                    label: ValueListenableBuilder(
                      valueListenable: _repository.listenToSettings(
                        keys: ['codearq'],
                      ),
                      builder: (_, __, ___) {
                        String codearq = _repository.codearq;
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
                    context.pop(); // Close drawer
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => CodearqEditor(),
                    );
                  },
                ),
                SwitchListTile(
                  title: const Text('Modo Noturno'),
                  activeColor: context.accentColor,
                  value: _repository.isDarkMode,
                  onChanged: (_) async {
                    context.read<HomeController>().toggleSaving(value: true);

                    // TODO: Move to HomeBloc
                    await HiveRepository.settingsBox.put('darkMode', _);

                    context.read<HomeController>().toggleSaving(value: false);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
