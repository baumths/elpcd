import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repositories/hive_repository.dart';
import '../../../../shared/shared.dart';
import 'widgets.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _repository = context.watch<HiveRepository>();
    return Drawer(
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
          ListTile(
            title: const Text('Download CSV'),
            trailing: const Icon(Icons.file_download),
            onTap: () {
              context.pop(); // Close drawer
              ShowSnackBar.info(
                context,
                'Aguarde enquanto preparamos o seu arquivo!',
              );

              //! Convert CsvExport into a bloc to show progress in UI
              CsvExport(_repository).downloadCsvFile();
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
            onChanged: (_) => HiveRepository.settingsBox.put('darkMode', _),
          ),
        ],
      ),
    );
  }
}
