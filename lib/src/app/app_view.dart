import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database/hive_database.dart';
import '../edit/edit.dart';
import '../home/home.dart';

class ElPCDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveDatabase.settingsBox.listenable(keys: ['darkMode']),
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

abstract class AppTheme {
  static ThemeData themeData(bool darkMode) {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue.shade900,
      accentColor: Colors.orange,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: darkMode ? Brightness.dark : Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 2),
        ),
      ),
      hoverColor: darkMode
          ? Colors.white.withOpacity(0.15)
          : Colors.grey.withOpacity(0.5),
    );
  }
}
