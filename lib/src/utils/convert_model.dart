import 'dart:html' as html;
import 'dart:convert' as convert;

import 'package:csv/csv.dart';

import 'package:elpcd_dart/src/database/hive_database.dart';
import 'package:elpcd_dart/src/models/pcd_model.dart';

class ConvertModel {
  ConvertModel() {
    this.prepareDownload();
  }

  List<String> get _atomColumns => [
        'referenceCode',
        'repository',
        'legacyId',
        'parentId',
        'identifier',
        'title',
        'scopeAndContent',
        'arrangement',
        'appraisal',
      ];

  List<String> get _repositoryRow {
    String codearq = HiveDatabase.settingsBox.get(
      'codearq',
      defaultValue: 'ElPCD',
    );
    return [codearq, codearq, '-1', '', codearq, codearq, '', '', ''];
  }

  List<String> toCsv(PCDModel model) {
    var scopeAndContent = """
Registro de abertura: ${model.registroAbertura}\n
Registro de desativação: ${model.registroDesativacao}\n
Indicador de classe ativa/inativa: ${model.indicador}\n
""";

    var arrangement = """
Reativação de classe: ${model.registroReativacao}\n
Registro de mudança de nome de classe: ${model.registroMudancaNome}\n
Registro de deslocamento de classe: ${model.registroDeslocamento}\n
Registro de extinção: ${model.registroExtincao}\n
""";
    var appraisal = """
Prazo de guarda na fase corrente: ${model.prazoCorrente}\n
Evento que determina a contagem do prazo de guarda na fase corrente: ${model.eventoCorrente}\n
Prazo de guarda na fase intermediária: ${model.prazoIntermediaria}\n
Evento que determina a contagem do prazo de guarda na fase intermediária: ${model.eventoIntermediaria}\n
Destinação final: ${model.destinacaoFinal}\n
Registro de alteração: ${model.registroAlteracao}\n
Observações: ${model.observacoes}\n
""";

    return <String>[
      model.identifier,
      '',
      model.legacyId.toString(),
      model.parentId.toString(),
      model.codigo,
      model.nome,
      scopeAndContent,
      arrangement,
      appraisal,
    ];
  }

  Future<String> _setupCsvFile() async {
    List<List<String>> rows = [this._atomColumns, this._repositoryRow];
    HiveDatabase.pcdBox.values.forEach((pcd) {
      if (pcd != null) rows.add(this.toCsv(pcd));
    });
    return ListToCsvConverter().convert(rows);
  }

  prepareDownload({String fileName = 'ElPCD'}) async {
    var csv = await this._setupCsvFile();

    final bytes = convert.utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..type = 'text/csv;charset=utf-8'
      ..download = fileName + '.csv';
    html.document.body.children.add(anchor);

    // download
    anchor.click();

    // cleanup
    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
