import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:elpcd_dart/src/database/hive_database.dart';
import 'widgets/widgets.dart';

class HomeView extends StatelessWidget {
  final settingsBox = Hive.box(HiveDatabase.settingsBox);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Elaborador de PCD & TTD'),
          leading: Switch(
            activeColor: Theme.of(context).accentColor,
            value: settingsBox.get('darkMode', defaultValue: true),
            onChanged: (value) => settingsBox.put('darkMode', value),
          ),
          actions: [
            FlatButton.icon(
              hoverColor: Colors.white10,
              icon: Icon(Icons.edit, color: Colors.white),
              label: Row(
                children: [
                  Text('CODEARQ ➜ ', style: TextStyle(color: Colors.white)),
                  ValueListenableBuilder(
                    valueListenable: settingsBox.listenable(keys: ['codearq']),
                    builder: (_, box, __) {
                      var codearq = box.get('codearq', defaultValue: 'ElPCD');
                      return Text(
                        '$codearq',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
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
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          hoverElevation: 12,
          label: Text('OPÇÔES'),
          icon: Icon(Icons.segment),
          onPressed: () {},
        ),
        body: TreeviewWidget(),
      ),
    );
  }
}
