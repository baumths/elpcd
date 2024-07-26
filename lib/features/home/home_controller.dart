import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  bool isSaving = false;

  void toggleSaving({required bool value}) {
    isSaving = value;
    notifyListeners();
  }
}
