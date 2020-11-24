import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/hive_repository.dart';
import '../features.dart';
import 'app_theme.dart';

class ElPCDApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _repository = RepositoryProvider.of<HiveRepository>(context);
    return ValueListenableBuilder(
      valueListenable: _repository.listenToSettings(keys: ['darkMode']),
      builder: (_, __, ___) {
        return MaterialApp(
          title: 'ElPCD',
          debugShowCheckedModeBanner: false,
          themeMode: _repository.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.themeData(darkMode: _repository.isDarkMode),
          initialRoute: HomeView.routeName,
          routes: {
            HomeView.routeName: (_) => const HomeView(),
            ComposeView.routeName: (_) => const ComposeView(),
          },
        );
      },
    );
  }
}
