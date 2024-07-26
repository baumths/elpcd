import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

const defaultCodearq = 'ElPCD';
const defaultDarkMode = true;

class SettingsController with ChangeNotifier {
  SettingsController(this._box) {
    _codearq = _box.get('codearq') as String? ?? defaultCodearq;
    _darkMode = _box.get('darkMode') as bool? ?? defaultDarkMode;
  }

  final Box<Object> _box;

  String get codearq => _codearq;
  String _codearq = defaultCodearq;

  bool get darkMode => _darkMode;
  bool _darkMode = defaultDarkMode;

  void updateCodearq(String value) {
    value = value.trim();
    if (value == codearq) {
      return;
    }
    _codearq = value.isEmpty ? defaultCodearq : value;
    notifyListeners();
    _box.put('codearq', codearq);
  }

  void updateDarkMode(bool value) {
    if (value == darkMode) return;
    _darkMode = value;
    notifyListeners();
    _box.put('darkMode', darkMode);
  }
}
