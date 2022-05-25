import 'dart:collection';

class Class {
  const Class({
    required this.id,
    required this.parentId,
    required this.name,
    required this.code,
    required this.childrenIds,
    required this.metadata,
  });

  final String id;
  final String parentId;

  final String name;
  final String code;

  final Set<String> childrenIds;
  final Map<String, String> metadata;
}

enum Earq {
  subordinacao,
  indicadorUso,
  indicadorAtiva,
  prazoCorrente,
  eventoCorrente,
  prazoIntermediaria,
  eventoIntermediaria,
  destinacao,
  sigilo,
  observacao,
}

extension EarqLabels on Earq {
  String get label {
    return <Earq, String>{
      Earq.subordinacao: "Subordinação da classe",
      Earq.indicadorUso: "Indicação de permissão de uso",
      Earq.indicadorAtiva: "Indicação de classe ativa/inativa",
      Earq.prazoCorrente: "Prazo na idade corrente",
      Earq.eventoCorrente: "Evento de contagem na idade corrente",
      Earq.prazoIntermediaria: "Prazo na idade intermediária",
      Earq.eventoIntermediaria: "Evento de contagem na idade intermediária",
      Earq.destinacao: "Destinação final",
      Earq.sigilo: "Sigilo associado à classe",
      Earq.observacao: "Observação",
    }[this]!;
  }
}

class EarqMetadata {
  EarqMetadata();

  static const Map<String, bool> _validLabels = <String, bool>{
    "Subordinação da classe": true,
    "Indicação de permissão de uso": true,
    "Indicação de classe ativa/inativa": true,
    "Prazo na idade corrente": true,
    "Evento de contagem na idade corrente": true,
    "Prazo na idade intermediária": true,
    "Evento de contagem na idade intermediária": true,
    "Destinação final": true,
    "Sigilo associado à classe": true,
    "Observação": true,
  };

  static Iterable<String> get labels => _validLabels.keys;

  final Map<String, String> _metadata = <String, String>{};

  UnmodifiableMapView<String, String> get metadata {
    return UnmodifiableMapView<String, String>(_metadata);
  }

  bool contains(String label) => _metadata[label] != null;

  String? operator [](String label) => _metadata[label];

  void operator []=(String label, String value) {
    if (_validLabels[label] ?? false) {
      _metadata[label] = value;
    }
  }
}
