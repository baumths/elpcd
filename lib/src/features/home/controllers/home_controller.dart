import 'package:flutter/material.dart';

import '../../../repositories/hive_repository.dart';
import '../../../shared/shared.dart';

//! TODO: CONVERT TO BLOC

class HomeController with ChangeNotifier {
  String _newCodearq = 'ElPCD';

  void changeCodearq(String value) {
    _newCodearq = value.trim().isEmpty ? 'ElPCD' : value.trim();
  }

  void navigationRequested(BuildContext context, String route, {Object args}) {
    Navigator.of(context).pushNamed(route, arguments: args);
  }

  Future<void> saveCodearq(BuildContext context) async {
    await HiveRepository.settingsBox.put('codearq', _newCodearq);
    Navigator.of(context).pop();
    ShowSnackBar.info(context, 'CODEARQ alterado para ➜ $_newCodearq');
  }
}
