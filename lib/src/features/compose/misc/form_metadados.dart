import 'package:flutter/material.dart';

import 'metadata_viewmodel.dart';

// TODO: Maybe use a Cubit instead

class FormMetadados extends ChangeNotifier {
  static const int max = 14;

  List<MetadataViewModel> metadados = <MetadataViewModel>[];

  bool get canAddMetadados => metadados.length < max;

  void setInitialMetadados(List<MetadataViewModel> initialMetadados) {
    if (initialMetadados.isEmpty) return;
    metadados = initialMetadados;
    for (final m in initialMetadados) {
      _isPresent[m.type] = true;
    }
    // Only notify when all metadados have been added,
    // instead of calling `addMetadado` for each metadado
    notifyListeners();
  }

  void addMetadado(MetadataViewModel value) {
    if (isPresent(value.type)) return;
    metadados.add(value);
    _isPresent[value.type] = true;
    notifyListeners();
  }

  void removeMetadado(MetadataViewModel value) {
    if (isPresent(value.type)) {
      metadados.remove(value);
      _isPresent[value.type] = false;
      notifyListeners();
    }
  }

  bool isPresent(String value) => _isPresent[value];

  final Map<String, bool> _isPresent = {
    'Registro de Abertura': false,
    'Registro de Desativação': false,
    'Reativação da Classe': false,
    'Registro de Mudança de Nome de Classe': false,
    'Registro de Deslocamento de Classe': false,
    'Registro de Extinção': false,
    'Indicador de Classe Ativa/Inativa': false,
    'Prazo de Guarda na Fase Corrente': false,
    'Evento que Determina a Contagem do Prazo de Guarda na Fase Corrente':
        false,
    'Prazo de Guarda na Fase Intermediária': false,
    'Evento que Determina a Contagem do Prazo de Guarda na Fase Intermediária':
        false,
    'Destinação Final': false,
    'Registro de Alteração': false,
    'Observações': false,
  };
}
