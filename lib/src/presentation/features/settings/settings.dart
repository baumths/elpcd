import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PhysicalKeyboardKey;

import '../../theme/theme.dart';

part '_utils.dart';
part 'widgets/_browse_type.dart';
part 'widgets/_codearq.dart';
part 'widgets/_section.dart';

class Settings extends StatelessWidget {
  const Settings({
    Key key = const Key('Settings'),
  }) : super(key: key);

  static const List<SettingsSectionModel> sections = [
    SettingsSectionModel(
      title: 'VISUALIZAÇÃO',
      body: BrowseTypeSection(),
    ),
    SettingsSectionModel(
      title: 'CODEARQ',
      infoTooltip: 'O CODEARQ é salvo automaticamente',
      body: CodearqSection(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Scrollbar(
        child: ListView.separated(
          itemCount: Settings.sections.length,
          padding: const EdgeInsets.all(AppEdgeInsets.small),
          separatorBuilder: (_, __) => const SizedBox(
            height: AppEdgeInsets.medium,
          ),
          itemBuilder: (_, int index) => SettingsSection(
            model: Settings.sections[index],
          ),
        ),
      ),
    );
  }
}
