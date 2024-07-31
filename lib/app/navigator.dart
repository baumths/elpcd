import 'package:flutter/material.dart';

import '../../entities/classe.dart';
import '../../shared/dialogs.dart';
import '../features/settings/institution_code.dart';
import '../features/settings/settings_controller.dart';

final navigatorKey = GlobalKey<NavigatorState>();

enum AppRoutes {
  classEditor('/compose'),
  home('/'),
  ;

  const AppRoutes(this.routeName);
  final String routeName;
}

void pop<T extends Object?>([T? result]) {
  navigatorKey.currentState!.pop<T>(result);
}

void closeClassEditor() => pop();

void showClassEditor({Classe? classe}) {
  navigatorKey.currentState!.pushNamed(
    AppRoutes.classEditor.routeName,
    arguments: classe,
  );
}

void showInstitutionCodeEditor(SettingsController settings) {
  showModalBottomSheet<void>(
    context: navigatorKey.currentContext!,
    builder: (context) => InstitutionCodeEditor(
      institutionCode: settings.institutionCode,
      onSubmitted: (String value) {
        settings.updateInstitutionCode(value);
        pop();
      },
      onDismissed: () => pop(),
    ),
  );
}

Future<bool?> showWarningDialog({
  required String title,
  required String confirmButtonText,
}) {
  return showDialog<bool>(
    context: navigatorKey.currentContext!,
    builder: (_) => WarningDialog(
      title: title,
      confirmButtonText: confirmButtonText,
      onCancel: () => pop<bool>(false),
      onConfirm: () => pop<bool>(true),
    ),
  );
}
