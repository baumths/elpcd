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

  String getReferenceCode() => _buildReferenceCode(this);

  String _buildReferenceCode(PCDModel child) {
    if (child.parentId == 0) {
      Box settingsBox = Hive.box(HiveDatabase.settingsBox);
      String codearq = settingsBox.get('codearq') ?? 'ElPCD';
      return '$codearq ${child.codigo}';
    }
    Box pcdBox = Hive.box<PCDModel>(HiveDatabase.pcdBox);
    var pcd = pcdBox.values.firstWhere(
      (i) => i.legacyId == child.parentId,
    );
    return '${_buildReferenceCode(pcd)}-${child.codigo}';
  }
}
