import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/entities.dart';

class FormMetadados extends ChangeNotifier {
  static const int max = 14;

  final List<Metadado> _metadados = <Metadado>[];
  List<Metadado> get metadados => _metadados;

  bool get canAddMetadados => _metadados.length < max;

  void addMetadado(Metadado value) {
    if (isPresent(value.type)) {
      print('=> Este metadado já existe');
    } else {
      _metadados.add(value);
      _isPresent[value.type] = true;
      notifyListeners();
    }
  }

  void removeMetadado(Metadado value) {
    if (isPresent(value.type)) {
      _metadados.remove(value);
      _isPresent[value.type] = false;
      notifyListeners();
    } else {
      print('=> Metadado não existe');
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

extension FormMetadadosX on BuildContext {
  FormMetadados get formMetadados {
    return Provider.of<FormMetadados>(this, listen: false);
  }
}
