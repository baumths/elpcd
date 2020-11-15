import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../database/hive_database.dart';
import '../../../shared/shared.dart';
import 'widgets.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              CsvExport().downloadCsvFile();
            },
          ),
          ListTile(
            title: const Text('Editar CODEARQ'),
            trailing: Chip(
              label: ValueListenableBuilder(
                valueListenable: HiveDatabase.settingsBox.listenable(),
                builder: (_, box, __) {
                  String codearq =
                      box.get('codearq', defaultValue: 'ElPCD') as String;
                  if (codearq.length > 9) {
                    codearq = '${codearq.substring(0, 10)}...';
                  }
                  return Text(
                    codearq,
                    overflow: TextOverflow.ellipsis,
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
            value: HiveDatabase.settingsBox.get(
              'darkMode',
              defaultValue: true,
            ) as bool,
            onChanged: (value) =>
                HiveDatabase.settingsBox.put('darkMode', value),
          ),
        ],
      ),
    );
  }
}
