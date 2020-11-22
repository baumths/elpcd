import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../repositories/hive_repository.dart';
import '../misc/app_routes.dart';
import '../misc/app_theme.dart';

class ElPCDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _repository = context.watch<HiveRepository>();
    return ValueListenableBuilder(
      valueListenable: HiveRepository.classesBox.listenable(keys: ['darkMode']),
      builder: (_, __, ___) {
        return MaterialApp(
          title: 'ElPCD',
          debugShowCheckedModeBanner: false,
          themeMode: _repository.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.themeData(darkMode: _repository.isDarkMode),
          initialRoute: ElPCDRouter.home,
          onGenerateRoute: ElPCDRouter.onGenerateRoute,
        );
      },
    );
  }
}
