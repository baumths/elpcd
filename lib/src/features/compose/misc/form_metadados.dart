import 'package:flutter/material.dart';

import '../../../entities/entities.dart';

// TODO: Maybe use a Cubit instead

class FormMetadados extends ChangeNotifier {
  static const int max = 14;

  List<Metadado> metadados = const [];

  bool get canAddMetadados => metadados.length < max;

  void setInitialMetadados(List<Metadado> initialMetadados) {
    if (initialMetadados.isEmpty) return;
    metadados = initialMetadados;
    for (final m in initialMetadados) {
      _isPresent[m.type] = true;
    }
    // Only notify when all metadados have been added,
    // instead of calling `addMetadado` for each metadado
    notifyListeners();
  }

  void addMetadado(Metadado value) {
    if (isPresent(value.type)) return;
    metadados.add(value);
    _isPresent[value.type] = true;
    notifyListeners();
  }

  void removeMetadado(Metadado value) {
    if (isPresent(value.type)) {
      metadados.remove(value);
      _isPresent[value.type] = false;
      notifyListeners();
    }
  }

  bool isPresent(Metadados value) => _isPresent[value];

  final Map<Metadados, bool> _isPresent = {
    Metadados.registroAbertura: false,
    Metadados.registroDesativacao: false,
    Metadados.registroReativacao: false,
    Metadados.registroMudancaNome: false,
    Metadados.registroDeslocamento: false,
    Metadados.registroExtincao: false,
    Metadados.indicador: false,
    Metadados.prazoCorrente: false,
    Metadados.eventoCorrente: false,
    Metadados.prazoIntermediaria: false,
    Metadados.eventoIntermediaria: false,
    Metadados.destinacaoFinal: false,
    Metadados.registroAlteracao: false,
    Metadados.observacoes: false,
  };
}
