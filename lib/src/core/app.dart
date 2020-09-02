import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:elpcd_dart/src/database/hive_database.dart';
import 'package:elpcd_dart/src/views/views.dart';

part 'app_theme.dart';

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
          home: HomeView(),
        );
      },
    );
  }
}
