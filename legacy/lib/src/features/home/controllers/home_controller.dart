import 'package:flutter/material.dart';

import '../../../repositories/hive_repository.dart';
import '../../../shared/shared.dart';

class HomeController with ChangeNotifier {
  String _newCodearq = 'ElPCD';
  bool isSaving = false;

  void toggleSaving({required bool value}) {
    isSaving = value;
    notifyListeners();
  }

  void changeCodearq(String value) {
    _newCodearq = value.trim().isEmpty ? 'ElPCD' : value.trim();
  }

  Future<void> saveCodearq(BuildContext context) async {
    await HiveRepository.settingsBox.put('codearq', _newCodearq);
    Navigator.of(context).pop();
    ShowSnackBar.info(context, 'CODEARQ alterado para ➜ $_newCodearq');
  }
}
