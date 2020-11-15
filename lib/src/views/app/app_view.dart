import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../database/hive_database.dart';
import '../views.dart';

class ElPCDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveDatabase.settingsBox.listenable(keys: ['darkMode']),
      builder: (_, settingsBox, __) {
        final darkMode =
            settingsBox.get('darkMode', defaultValue: true) as bool;
        return MaterialApp(
          title: 'ElPCD',
          debugShowCheckedModeBanner: false,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.themeData(darkMode: darkMode),
          // initialRoute: HomeView.routeName,
          initialRoute: ComposeView.routeName,
          routes: {
            HomeView.routeName: (_) => HomeView(),
            BrowseView.routeName: (_) => BrowseView(),
            ComposeView.routeName: (_) => ComposeView(),
          },
        );
      },
    );
  }
}

abstract class AppTheme {
  static ThemeData themeData({bool darkMode = true}) {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue.shade900,
      accentColor: Colors.orange,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: darkMode ? Brightness.dark : Brightness.light,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 2),
        ),
      ),
      hoverColor: darkMode
          ? Colors.white.withOpacity(0.15)
          : Colors.grey.withOpacity(0.5),
    );
  }
}
