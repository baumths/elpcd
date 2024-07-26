import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../compose/compose.dart';
import '../home/home.dart';
import '../settings/settings_controller.dart';
import 'app_theme.dart';

class ElPCDApp extends StatelessWidget {
  const ElPCDApp({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = context.select<SettingsController, bool>(
      (controller) => controller.darkMode,
    );
    return MaterialApp(
      title: 'ElPCD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(darkMode: darkMode),
      initialRoute: HomeView.routeName,
      routes: {
        HomeView.routeName: (_) => const HomeView(),
        ComposeView.routeName: (_) => const ComposeView(),
      },
    );
  }
}
