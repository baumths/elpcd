import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:elpcd_dart/src/database/hive_database.dart';
import 'package:elpcd_dart/src/managers/managers.dart';
import 'package:elpcd_dart/src/models/pcd_model.dart';
import 'package:elpcd_dart/src/utils/utils.dart';
import 'widgets/treeview/tree_view.dart';

part 'widgets/codearq_bottom_sheet.dart';
part 'widgets/tree_view_widget.dart';

class HomeView extends StatelessWidget {
  final settingsBox = HiveDatabase.settingsBox;
  @override
  Widget build(BuildContext context) {
    var homeManager = context.watch<HomeManager>();
    return Scaffold(
      key: homeManager.scaffoldKey,
      appBar: AppBar(
        title: const Text('ElPCD'),
        leading: this._buildDrawerButton(context),
      ),
      floatingActionButton: this._buildFAB(context),
      drawer: this._buildDrawer(context),
      body: TreeViewWidget(),
    );
  }

  Widget _buildDrawerButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.segment),
      tooltip: 'Configurações',
      splashRadius: 24,
      onPressed: () {
        var homeManager = context.read<HomeManager>();
        homeManager.scaffoldKey.currentState.openDrawer();
      },
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      hoverColor: Colors.white10,
      label: const Text('NOVA CLASSE'),
      icon: const Icon(Icons.post_add),
      onPressed: () {
        var homeManager = context.read<HomeManager>();
        homeManager.openDescription(context, DescriptionManager.newClass());
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: const SizedBox.shrink(),
            decoration: const BoxDecoration(
              color: Colors.white,
              image: const DecorationImage(
                image: const AssetImage('assets/gedalogo_270x270.png'),
              ),
            ),
          ),
          ListTile(
            title: const Text('Editar CODEARQ'),
            trailing: Chip(
              label: ValueListenableBuilder(
                valueListenable: HiveDatabase.settingsBox.listenable(),
                builder: (_, box, __) {
                  String codearq = box.get('codearq', defaultValue: 'ElPCD');
                  if (codearq.length > 10) {
                    codearq = codearq.substring(0, 10) + '...';
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
              showModalBottomSheet(
                context: context,
                builder: (_) => CodearqEditor(),
              );
            },
          ),
          SwitchListTile(
            title: const Text('Modo Noturno'),
            activeColor: context.accentColor,
            value: this.settingsBox.get('darkMode', defaultValue: true),
            onChanged: (value) => this.settingsBox.put('darkMode', value),
          ),
        ],
      ),
    );
  }
}
