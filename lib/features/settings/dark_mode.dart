import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../localization.dart';
import 'settings_controller.dart';

class DarkModeSwitchIconButton extends StatelessWidget {
  const DarkModeSwitchIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = context.select<SettingsController, bool?>(
      (controller) => controller.darkMode,
    );

    final (icon, nextValue) = switch (darkMode) {
      null => (LucideIcons.sunMoon, true),
      true => (LucideIcons.moon, false),
      false => (LucideIcons.sun, null),
    };

    return IconButton(
      tooltip: AppLocalizations.of(context).themeModeButtonText,
      icon: Icon(icon),
      onPressed: () {
        context.read<SettingsController>().updateDarkMode(nextValue);
      },
    );
  }
}
