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
