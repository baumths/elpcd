part of 'classe.dart';

enum Metadados {
  registroAbertura,
  registroDesativacao,
  registroReativacao,
  registroMudancaNome,
  registroDeslocamento,
  registroExtincao,
  indicador,
  prazoCorrente,
  eventoCorrente,
  prazoIntermediaria,
  eventoIntermediaria,
  destinacaoFinal,
  registroAlteracao,
  observacoes,
}

class Metadado {
  Metadado({@required this.type, this.content = ''});

  final Metadados type;

  String content;

  String get label => type.asString();

  String toCsv() => '$label: $content\n\n';
}

extension MetadadosX on Metadados {
  String asString() {
    switch (this) {
      case Metadados.registroAbertura:
        return 'Registro de Abertura';
      case Metadados.registroDesativacao:
        return 'Registro de Desativação';
      case Metadados.registroReativacao:
        return 'Reativação da Classe';
      case Metadados.registroMudancaNome:
        return 'Registro de Mudança de Nome de Classe';
      case Metadados.registroDeslocamento:
        return 'Registro de Deslocamento de Classe';
      case Metadados.registroExtincao:
        return 'Registro de Extinção';
      case Metadados.indicador:
        return 'Indicador de Classe Ativa/Inativa';
      case Metadados.prazoCorrente:
        return 'Prazo de Guarda na Fase Corrente';
      case Metadados.eventoCorrente:
        return 'Evento que Determina a Contagem do Prazo de Guarda na Fase Corrente';
      case Metadados.prazoIntermediaria:
        return 'Prazo de Guarda na Fase Intermediária';
      case Metadados.eventoIntermediaria:
        return 'Evento que Determina a Contagem do Prazo de Guarda na Fase Intermediária';
      case Metadados.destinacaoFinal:
        return 'Destinação Final';
      case Metadados.registroAlteracao:
        return 'Registro de Alteração';
      case Metadados.observacoes:
        return 'Observações';
      default:
        throw UnimplementedError();
    }
  }
}
