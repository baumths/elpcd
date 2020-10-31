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

  List<PCDModel> get children => HiveDatabase.getChildren(parent: this);

  bool get hasChildren => HiveDatabase.hasChildren(this);

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

  List<String> toCsv() {
    var scopeAndContent = """
Registro de abertura: $registroAbertura\n
Registro de desativação: $registroDesativacao\n
Indicador de classe ativa/inativa: $indicador\n
""";

    var arrangement = """
Reativação de classe: $registroReativacao\n
Registro de mudança de nome de classe: $registroMudancaNome\n
Registro de deslocamento de classe: $registroDeslocamento\n
Registro de extinção: $registroExtincao\n
""";
    var appraisal = """
Prazo de guarda na fase corrente: $prazoCorrente\n
Evento que determina a contagem do prazo de guarda na fase corrente: $eventoCorrente\n
Prazo de guarda na fase intermediária: $prazoIntermediaria\n
Evento que determina a contagem do prazo de guarda na fase intermediária: $eventoIntermediaria\n
Destinação final: $destinacaoFinal\n
Registro de alteração: $registroAlteracao\n
Observações: $observacoes\n
""";
    return <String>[
      identifier,
      '',
      legacyId.toString(),
      parentId.toString(),
      codigo,
      nome,
      scopeAndContent,
      arrangement,
      appraisal,
    ];
  }
}
