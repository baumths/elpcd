import 'package:flutter/material.dart';

import 'metadata_viewmodel.dart';

// TODO: Maybe use a Cubit instead

class FormMetadata extends ChangeNotifier {
  static const int maxMetadata = 14;

  List<MetadataViewModel> metadata = <MetadataViewModel>[];

  bool get canAddMetadata => metadata.length < maxMetadata;

  void setInitialMetadata(List<MetadataViewModel> initialMetadata) {
    if (initialMetadata.isEmpty) return;
    metadata = initialMetadata;
    for (final m in initialMetadata) {
      _isPresent[m.type] = true;
    }
    // Only notify when all metadados have been added,
    // instead of calling `addMetadado` for each metadado
    notifyListeners();
  }

  void addMetadata(MetadataViewModel value) {
    if (isPresent(value.type)) return;
    metadata.add(value);
    _isPresent[value.type] = true;
    notifyListeners();
  }

  void removeMetadata(MetadataViewModel value) {
    if (isPresent(value.type)) {
      metadata.remove(value);
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
