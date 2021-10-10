import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme/theme.dart';

import 'controllers/browser_type.dart';
import 'controllers/codearq.dart';

part '_utils.dart';
part 'widgets/_browser_type.dart';
part 'widgets/_codearq.dart';
part 'widgets/_section.dart';

class Settings extends StatefulWidget {
  const Settings({
    Key key = const Key('Settings'),
  }) : super(key: key);

  static const List<SettingsSectionModel> sections = [
    SettingsSectionModel(
      title: 'VISUALIZAÇÃO',
      body: BrowserTypeSection(),
    ),
    SettingsSectionModel(
      title: 'CODEARQ',
      infoTooltip: 'O CODEARQ é salvo automaticamente',
      body: CodearqSection(),
    ),
  ];

  static SettingsScope of(BuildContext context) {
    final obj = context.dependOnInheritedWidgetOfExactType<SettingsScope>();
    assert(obj != null, 'No Settings found in given BuildContext');
    return obj!;
  }

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late final BrowserTypeController browserTypeController;
  late final CodearqController codearqController;

  // TODO: Get from user preferences,
  String _codearq = 'ElPCD';

  void onCodearqSaved(String codearq) {
    codearq = codearq.trim();

    if (codearq.isNotEmpty && codearq != _codearq) {
      setState(() {
        _codearq = codearq;
      });
    }
    // TODO: Save in user preferences;
  }

  @override
  void initState() {
    super.initState();
    browserTypeController = BrowserTypeController(
      // TODO: Get from user preferences
      initiallySelectedType: 'Hierárquica',
      onChanged: (String type) {
        // TODO: Save in user preferences
      },
    );
    codearqController = CodearqController(
      onSaved: onCodearqSaved,
    );
  }

  @override
  void dispose() {
    browserTypeController.dispose();
    codearqController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsScope(
      browserTypeController: browserTypeController,
      codearqController: codearqController,
      codearq: _codearq,
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
