import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

import 'package:elpcd_dart/src/database/hive_database.dart';
import 'package:elpcd_dart/src/managers/managers.dart';
import 'package:elpcd_dart/src/models/pcd_model.dart';
import 'package:elpcd_dart/src/utils/utils.dart';

import '../views.dart';

part 'widgets/codearq_bottom_sheet.dart';
part 'widgets/tree_node_widget.dart';
part 'widgets/treeview_widget.dart';

class HomeView extends StatelessWidget {
  final settingsBox = HiveDatabase.settingsBox;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.watch<HomeManager>().scaffoldKey,
      appBar: AppBar(
        title: const Text('ElPCD'),
        leading: this._buildDrawerButton(context),
        actions: _buildActions(context),
      ),
      floatingActionButton: this._buildFAB(context),
      drawer: this._buildDrawer(context),
      body: TreeviewWidget(),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final manager = context.watch<TreeManager>();
    final expanded = manager.allNodesExpanded;
    return [
      IconButton(
        splashRadius: 20,
        icon: Icon(expanded ? Icons.unfold_less : Icons.unfold_more),
        tooltip: expanded ? 'Recolher Classes' : 'Expandir Classes',
        onPressed: expanded ? manager.collapseAll : manager.expandAll,
      ),
      const SizedBox(width: 8),
    ];
  }

  Widget _buildDrawerButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.segment),
      tooltip: 'Configurações',
      splashRadius: 24,
      onPressed: () {
        context.read<HomeManager>().scaffold.openDrawer();
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
                  String codearq = box.get('codearq', defaultValue: 'ElPCD');
                  if (codearq.length > 9) {
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
            value: this.settingsBox.get('darkMode', defaultValue: true),
            onChanged: (value) => this.settingsBox.put('darkMode', value),
          ),
        ],
      ),
    );
  }
}
