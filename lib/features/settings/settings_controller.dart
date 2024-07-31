import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

const defaultInstitutionCode = 'ElPCD';
const defaultDarkMode = true;

class SettingsController with ChangeNotifier {
  SettingsController(this._box) {
    _institutionCode = _box.get('codearq') as String? ?? defaultInstitutionCode;
    _darkMode = _box.get('darkMode') as bool? ?? defaultDarkMode;
  }

  final Box<Object> _box;

  String get institutionCode => _institutionCode;
  String _institutionCode = defaultInstitutionCode;

  bool get darkMode => _darkMode;
  bool _darkMode = defaultDarkMode;

  void updateInstitutionCode(String value) {
    value = value.trim();
    if (value == institutionCode) {
      return;
    }
    _institutionCode = value.isEmpty ? defaultInstitutionCode : value;
    notifyListeners();
    _box.put('codearq', institutionCode);
  }

  void updateDarkMode(bool value) {
    if (value == darkMode) return;
    _darkMode = value;
    notifyListeners();
    _box.put('darkMode', darkMode);
  }
}
