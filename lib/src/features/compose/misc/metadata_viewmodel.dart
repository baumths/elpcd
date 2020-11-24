import 'package:flutter/foundation.dart';

const kMetadadosEArqBrasil = <String>{
  'Registro de Abertura',
  'Registro de Desativação',
  'Reativação da Classe',
  'Registro de Mudança de Nome de Classe',
  'Registro de Deslocamento de Classe',
  'Registro de Extinção',
  'Indicador de Classe Ativa/Inativa',
  'Prazo de Guarda na Fase Corrente',
  'Evento que Determina a Contagem do Prazo de Guarda na Fase Corrente',
  'Prazo de Guarda na Fase Intermediária',
  'Evento que Determina a Contagem do Prazo de Guarda na Fase Intermediária',
  'Destinação Final',
  'Registro de Alteração',
  'Observações',
};

class MetadataViewModel {
  MetadataViewModel({@required this.type, this.content = ''});

  final String type;

  String content;

  bool get isEmpty => content.isEmpty;
  bool get isNotEmpty => content.isNotEmpty;

  Map<String, String> toMap() => {type: content};
}
