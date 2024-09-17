import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

const defaultInstitutionCode = 'ElPCD';

class SettingsController with ChangeNotifier {
  SettingsController(this._box) {
    _institutionCode = _get<String?>('codearq') ?? defaultInstitutionCode;
    _darkMode = _get<bool?>('darkMode');
    _classEditorFullscreen = _get<bool?>('ClassEditor.fullscreen');
  }

  final Box<Object> _box;

  T _get<T>(String key) => _box.get(key) as T;

  String get institutionCode => _institutionCode;
  String _institutionCode = defaultInstitutionCode;

  bool? get darkMode => _darkMode;
  bool? _darkMode;

  bool get classEditorFullscreen => _classEditorFullscreen ?? true;
  bool? _classEditorFullscreen;

  void updateInstitutionCode(String value) {
    value = value.trim();
    if (value == institutionCode) {
      return;
    }
    _institutionCode = value.isEmpty ? defaultInstitutionCode : value;
    notifyListeners();
    _box.put('codearq', institutionCode);
  }

  void updateDarkMode(bool? value) {
    if (value == darkMode) return;
    _darkMode = value;
    notifyListeners();
    value == null ? _box.delete('darkMode') : _box.put('darkMode', value);
  }

  void updateClassEditorFullscreen(bool value) {
    if (value == classEditorFullscreen) return;
    _classEditorFullscreen = value;
    notifyListeners();
    _box.put('ClassEditor.fullscreen', value);
  }
}
