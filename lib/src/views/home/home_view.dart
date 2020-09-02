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
        leading: IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.segment),
          onPressed: () {
            // TODO: implement drawer
          },
        ),
        actions: [
          // TODO: move actions to drawer to clean UI
          darkModeSwitch(context),
          _ChangeCodearqButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        hoverColor: Colors.white10,
        label: const Text('NOVA CLASSE'),
        icon: const Icon(Icons.post_add),
        onPressed: () {
          homeManager.openDescription(context, DescriptionManager.newClass());
        },
      ),
      body: TreeViewWidget(),
    );
  }

  Widget darkModeSwitch(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Modo Escuro ➜', textAlign: TextAlign.center),
        Switch(
          activeColor: context.accentColor,
          value: this.settingsBox.get('darkMode', defaultValue: true),
          onChanged: (value) => this.settingsBox.put('darkMode', value),
        ),
      ],
    );
  }
}

class _ChangeCodearqButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      hoverColor: Colors.white10,
      child: Row(
        children: [
          const Text('CODEARQ ➜ ', style: const TextStyle(color: Colors.white)),
          ValueListenableBuilder(
            valueListenable: HiveDatabase.settingsBox.listenable(),
            builder: (_, box, __) {
              String codearq = box.get('codearq', defaultValue: 'ElPCD');
              return Text(
                codearq,
                style: TextStyle(
                  color: context.accentColor,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),
              );
            },
          ),
        ],
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => CodearqEditor(),
        );
      },
    );
  }
}
