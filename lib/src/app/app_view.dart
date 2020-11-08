import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database/hive_database.dart';
import '../home/home.dart';
import '../edit/edit.dart';

import 'components/components.dart';

class ElPCDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveDatabase.settingsBox.listenable(),
      builder: (_, settingsBox, __) {
        var darkMode = settingsBox.get('darkMode', defaultValue: true);
        return MaterialApp(
          title: 'ElPCD',
          debugShowCheckedModeBanner: false,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.themeData(darkMode),
          initialRoute: HomeView.routeName,
          routes: {
            HomeView.routeName: (_) => HomeView(),
            EditView.routeName: (_) => EditView(),
          },
        );
      },
    );
  }
}
