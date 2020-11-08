import 'package:elpcd_dart/src/database/hive_database.dart';
import 'package:hive/hive.dart';

part 'pcd_model.g.dart';

@HiveType(typeId: 0)
class PCDModel with HiveObject {
  // IDs
  @HiveField(0)
  int legacyId;

  @HiveField(1)
  int parentId;
  // PCD
  @HiveField(2)
  String nome;

  @HiveField(3)
  String codigo;

  @HiveField(4)
  String subordinacao;

  @HiveField(5)
  String registroAbertura;

  @HiveField(6)
  String registroDesativacao;

  @HiveField(7)
  String registroReativacao;

  @HiveField(8)
  String registroMudancaNome;

  @HiveField(9)
  String registroDeslocamento;

  @HiveField(10)
  String registroExtincao;

  @HiveField(11)
  String indicador;
  // TTD
  @HiveField(12)
  String prazoCorrente;

  @HiveField(13)
  String eventoCorrente;

  @HiveField(14)
  String prazoIntermediaria;

  @HiveField(15)
  String eventoIntermediaria;

  @HiveField(16)
  String destinacaoFinal;

  @HiveField(17)
  String registroAlteracao;

  @HiveField(18)
  String observacoes;

  PCDModel({
    this.legacyId,
    this.parentId,
    this.nome,
    this.codigo,
    this.subordinacao,
    this.registroAbertura,
    this.registroDesativacao,
    this.registroReativacao,
    this.registroMudancaNome,
    this.registroDeslocamento,
    this.registroExtincao,
    this.indicador,
    this.prazoCorrente,
    this.eventoCorrente,
    this.prazoIntermediaria,
    this.eventoIntermediaria,
    this.destinacaoFinal,
    this.registroAlteracao,
    this.observacoes,
  });

  List<PCDModel> get children {
    return HiveDatabase.getClasses(legacyId: this.legacyId);
  }

  bool get hasChildren => HiveDatabase.hasChildren(this.legacyId);

  String get identifier => HiveDatabase.buildIdentifier(this);

  @override
  String toString() => '''\n
  ➜ ${this.identifier}
      legacyId ➜ ${this.legacyId}
      parentId ➜ ${this.parentId}
      Nome ➜ ${this.nome}
      Código ➜ ${this.codigo}
      Subordinação ➜ ${this.subordinacao}
      Abertura ➜ ${this.registroAbertura}
      Desativação ➜ ${this.registroDesativacao}
      Reativação ➜ ${this.registroReativacao}
      Mudança de Nome ➜ ${this.registroMudancaNome}
      Deslocameno ➜ ${this.registroDeslocamento}
      Extinção ➜ ${this.registroExtincao}
      Indicador ➜ ${this.indicador}
      Corrente ➜ ${this.prazoCorrente}
      Evento Corrente ➜ ${this.eventoCorrente}
      Intermediária ➜ ${this.prazoIntermediaria}
      Evento Intermediária ➜ ${this.eventoIntermediaria}
      Destinação ➜ ${this.destinacaoFinal}
      Alteração ➜ ${this.registroAlteracao}
      Observações ➜ ${this.observacoes}
''';

  List<String> toCsv() => <String>[
        identifier,
        '',
        legacyId.toString(),
        parentId.toString(),
        codigo,
        nome,
        _builScopeAndContent(),
        _buildArrangement(),
        _buildAppraisal(),
      ];

  String _builScopeAndContent() => <String>[
        if (registroAbertura?.isNotEmpty ?? false)
          'Registro de abertura: $registroAbertura',
        if (registroDesativacao?.isNotEmpty ?? false)
          'Registro de desativação: $registroDesativacao',
        if (indicador?.isNotEmpty ?? false)
          'Indicador de classe ativa/inativa: $indicador',
      ].join('\n\n');

  String _buildArrangement() => <String>[
        if (registroReativacao?.isNotEmpty ?? false)
          'Reativação de classe: $registroReativacao',
        if (registroMudancaNome?.isNotEmpty ?? false)
          'Registro de mudança de nome de classe: $registroMudancaNome',
        if (registroDeslocamento?.isNotEmpty ?? false)
          'Registro de deslocamento de classe: $registroDeslocamento',
        if (registroExtincao?.isNotEmpty ?? false)
          'Registro de extinção: $registroExtincao',
      ].join('\n\n');

  String _buildAppraisal() => <String>[
        if (prazoCorrente?.isNotEmpty ?? false)
          'Prazo de guarda na fase corrente: $prazoCorrente',
        if (eventoCorrente?.isNotEmpty ?? false)
          'Evento que determina a contagem do prazo de guarda na fase corrente: $eventoCorrente',
        if (prazoIntermediaria?.isNotEmpty ?? false)
          'Prazo de guarda na fase intermediária: $prazoIntermediaria',
        if (eventoIntermediaria?.isNotEmpty ?? false)
          'Evento que determina a contagem do prazo de guarda na fase intermediária: $eventoIntermediaria',
        if (destinacaoFinal?.isNotEmpty ?? false)
          'Destinação final: $destinacaoFinal',
        if (registroAlteracao?.isNotEmpty ?? false)
          'Registro de alteração: $registroAlteracao',
        if (observacoes?.isNotEmpty ?? false) 'Observações: $observacoes',
      ].join('\n\n');
}
