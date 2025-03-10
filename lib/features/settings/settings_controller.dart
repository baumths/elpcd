import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../../data/key_value_store.dart';

const defaultInstitutionCode = 'ElPCD';

class SettingsController with ChangeNotifier {
  SettingsController(this._store) {
    _institutionCode =
        _store.read<String?>('codearq') ?? defaultInstitutionCode;
    _darkMode = _store.read<bool?>('darkMode');
    _classEditorFullscreen = _store.read<bool?>('ClassEditor.fullscreen');
  }

  final KeyValueStore _store;

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
    _store.write('codearq', institutionCode);
  }

  void updateDarkMode(bool? value) {
    if (value == darkMode) return;
    _darkMode = value;
    notifyListeners();
    value == null ? _store.delete('darkMode') : _store.write('darkMode', value);
  }

  void updateClassEditorFullscreen(bool value) {
    if (value == classEditorFullscreen) return;
    _classEditorFullscreen = value;
    notifyListeners();
    _store.write('ClassEditor.fullscreen', value);
  }
}
