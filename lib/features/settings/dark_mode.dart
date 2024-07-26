import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings_controller.dart';

class DarkModeSwitchListTile extends StatelessWidget {
  const DarkModeSwitchListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = context.select<SettingsController, bool>(
      (controller) => controller.darkMode,
    );
    return SwitchListTile(
      title: const Text('Modo Noturno'),
      value: darkMode,
      onChanged: (bool value) {
        context.read<SettingsController>().updateDarkMode(value);
      },
    );
  }
}
