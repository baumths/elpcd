import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../database/hive_database.dart';
import '../../features.dart';
import '../misc/app_theme.dart';

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
          // onGenerateRoute: ElPCDRouter.onGenerateRoute,
          routes: {
            HomeView.routeName: (_) => HomeView(),
            ComposeView.routeName: (_) => const ComposeView(classe: null),
          },
        );
      },
    );
  }
}
