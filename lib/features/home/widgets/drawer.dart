import 'package:flutter/material.dart';

import '../../backup/backup_section.dart';
import '../../crosswalk/csv_export_list_tile.dart';
import '../../settings/codearq.dart';
import '../../settings/dark_mode.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/gedalogo_270x270.png'),
              ),
            ),
            child: SizedBox.shrink(),
          ),
          CodearqListTile(),
          DarkModeSwitchListTile(),
          Divider(),
          CsvExportListTile(),
          Divider(),
          BackupSection(),
        ],
      ),
    );
  }
}
