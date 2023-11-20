import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension UnlocalizedX on String {
  String get unlocalized => this;
}
