import 'package:flutter/material.dart';

import '../../../entities/entities.dart';
import '../../../repositories/hive_repository.dart';

class FormController with ChangeNotifier {
  FormController({@required this.hiveRepository, @required this.classe}) {
    _name = classe.name;
    _code = classe.code;
  }

  final String _validationErrorMessage = 'Campo obrigatório';
  final formKey = GlobalKey<FormState>();

  final HiveRepository hiveRepository;
  final Classe classe;

  String _name;
  String _code;

  bool _isEditing = false;
  bool _isSaving = false;

  void nameChanged(String value) => _name = value.trim();
  void codeChanged(String value) => _code = value.trim();

  String validateField(String value) {
    return value.trim().isEmpty ? _validationErrorMessage : '';
  }

  void saveForm(List<Metadado> metadados) {
    setSaving(true);
    final bool isFormValid = formKey.currentState.validate();
    if (isFormValid) {
      classe.name = _name;
      classe.code = _code;
      classe.metadados = _clearEmptyMetadados(metadados);

      //! Handle Saving the class
    } else {
      //! show SnackBar
    }
  }

  List<Metadado> _clearEmptyMetadados(List<Metadado> metadados) => metadados
      .where((m) => m.content != null && m.content.isNotEmpty)
      .toList();

  void setEditing(bool value) {
    _isEditing = value;
    notifyListeners();
  }

  void setSaving(bool value) {
    _isSaving = value;
    notifyListeners();
  }
}
