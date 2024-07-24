import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/hive_repository.dart';
import '../compose/compose.dart';
import '../home/home.dart';
import 'app_theme.dart';

class ElPCDApp extends StatelessWidget {
  const ElPCDApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<HiveRepository>(context);
    return ValueListenableBuilder(
      valueListenable: repository.listenToSettings(keys: ['darkMode']),
      builder: (_, __, ___) {
        return MaterialApp(
          title: 'ElPCD',
          debugShowCheckedModeBanner: false,
          themeMode: repository.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.themeData(darkMode: repository.isDarkMode),
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
