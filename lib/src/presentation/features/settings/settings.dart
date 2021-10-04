import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PhysicalKeyboardKey;

import '../../theme/theme.dart';

part '_utils.dart';
part 'widgets/_browser_type.dart';
part 'widgets/_section.dart';
part 'widgets/_codearq.dart';

class Settings extends StatelessWidget {
  const Settings({
    Key key = const Key('SettingsView'),
  }) : super(key: key);

  static const List<SettingsSectionModel> sections = [
    SettingsSectionModel(
      title: 'VISUALIZAÇÃO',
      body: BrowserTypeTile(),
    ),
    SettingsSectionModel(
      title: 'CODEARQ',
      infoTooltip: 'O CODEARQ é salvo automaticamente',
      body: CodearqTile(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        itemCount: Settings.sections.length,
        padding: const EdgeInsets.all(10),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, int index) {
          return SettingsSection(
            model: Settings.sections[index],
          );
        },
      ),
    );
  }
}
