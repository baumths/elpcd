import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:elpcd_dart/src/database/hive_database.dart';
import 'package:elpcd_dart/src/views/views.dart';

class ElPCDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(HiveDatabase.settingsBox).listenable(
        keys: ['darkMode'],
      ),
      builder: (_, settingsBox, __) {
        var darkMode = settingsBox.get('darkMode', defaultValue: true);
        return MaterialApp(
          title: 'ElPCD',
          debugShowCheckedModeBanner: false,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: darkMode ? Brightness.dark : Brightness.light,
          ),
          home: HomeView(),
        );
      },
    );
  }
}
