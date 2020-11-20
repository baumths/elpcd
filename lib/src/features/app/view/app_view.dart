import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repositories/hive_repository.dart';
import '../../features.dart';
import '../misc/app_theme.dart';

class ElPCDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _repository = context.watch<HiveRepository>();
    return ValueListenableBuilder(
      valueListenable: _repository.listenToSettings(keys: ['darkMode']),
      builder: (_, __, ___) {
        return MaterialApp(
          title: 'ElPCD',
          debugShowCheckedModeBanner: false,
          themeMode: _repository.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.themeData(darkMode: _repository.isDarkMode),
          initialRoute: HomeView.routeName,
          onGenerateRoute: ElPCDRouter.onGenerateRoute,
          routes: {
            HomeView.routeName: (_) => HomeView(),
            ComposeView.routeName: (_) => const ComposeView(classe: null),
          },
        );
      },
    );
  }
}
