import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localization.dart';
import 'settings_controller.dart';

class DarkModeSwitchListTile extends StatelessWidget {
  const DarkModeSwitchListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = context.select<SettingsController, bool?>(
      (controller) => controller.darkMode,
    );

    final (icon, nextValue) = switch (darkMode) {
      null => (Icons.settings_brightness, true),
      true => (Icons.dark_mode_outlined, false),
      false => (Icons.light_mode_outlined, null),
    };

    return ListTile(
      title: Text(AppLocalizations.of(context).themeModeButtonText),
      trailing: Icon(icon),
      onTap: () => context.read<SettingsController>().updateDarkMode(nextValue),
    );
  }
}
