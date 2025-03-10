import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/dashboard/dashboard.dart';
import '../features/settings/settings_controller.dart';
import '../localization.dart';
import 'app_theme.dart';
import 'navigator.dart';

class ElpcdAppView extends StatelessWidget {
  const ElpcdAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = context.select<SettingsController, bool?>(
      (controller) => controller.darkMode,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: createAppThemeWithBrightness(Brightness.light),
      darkTheme: createAppThemeWithBrightness(Brightness.dark),
      themeMode: switch (darkMode) {
        true => ThemeMode.dark,
        false => ThemeMode.light,
        null => ThemeMode.system,
      },
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      navigatorKey: navigatorKey,
      home: const Dashboard(),
    );
  }
}
