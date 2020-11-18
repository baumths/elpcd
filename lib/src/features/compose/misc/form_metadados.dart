import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/entities.dart';

extension FormMetadadosX on BuildContext {
  FormMetadados get formMetadados {
    return Provider.of<FormMetadados>(this, listen: false);
  }
}

class FormMetadados extends ChangeNotifier {
  FormMetadados({List<Metadado> metadados})
      : _metadados = metadados ?? <Metadado>[] {
    if (metadados.isNotEmpty) {
      metadados.forEach((m) => _isPresent[m.type] = true);
    }
  }
  static const int max = 14;

  final List<Metadado> _metadados;
  List<Metadado> get metadados => _metadados;

  bool get canAddMetadados => _metadados.length < max;

  void addMetadado(Metadado value) {
    if (isPresent(value.type)) return;
    _metadados.add(value);
    _isPresent[value.type] = true;
    notifyListeners();
  }

  void removeMetadado(Metadado value) {
    if (isPresent(value.type)) {
      _metadados.remove(value);
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
