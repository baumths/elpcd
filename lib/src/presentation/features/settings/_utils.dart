part of 'settings.dart';

class SettingsSectionModel {
  const SettingsSectionModel({
    required this.title,
    required this.body,
    this.infoTooltip,
  });

  final String title;
  final Widget body;
  final String? infoTooltip;
}

class SettingsScope extends InheritedWidget {
  const SettingsScope({
    Key? key,
    required Widget child,
    required this.browserTypeController,
  }) : super(key: key, child: child);

  final BrowserTypeController browserTypeController;

  @override
  bool updateShouldNotify(SettingsScope oldWidget) {
    return oldWidget.browserTypeController != browserTypeController;
  }
}
