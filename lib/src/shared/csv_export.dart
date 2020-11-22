import 'dart:convert' as convert;

import 'package:csv/csv.dart';
import 'package:universal_html/html.dart' as html;

import '../entities/entities.dart';
import '../repositories/hive_repository.dart';

/// Export classes as csv to be imported into the software
/// AtoM - AccessToMemory [https://accesstomemory.org]
class CsvExport {
  CsvExport(this._repository, {this.fileName = 'ElPCD'});

  final String fileName;

  final HiveRepository _repository;

  /// AtoM Standards
  List<String> get csvHeader => const <String>[
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

  /// Generate parent of all other classes so that
  /// AtoM can index classes properly
  List<String> get _accessToMemoryRepositoryRow {
    final codearq = _repository.codearq;
    return [codearq, codearq, '-1', '', codearq, codearq, '', '', ''];
  }

  // Converts a single classe into a `List<String>` to be "joined" into csv
  List<String> toCsv(Classe classe) {
    final metadata = AccessToMemoryMetadata(classe);
    return metadata.convert(_repository);
  }

  /// Converts classes from the database
  /// into the csv format to be written to a file
  Future<String> _databaseToCsv() async {
    //! FIXME: broken
    final List<List<String>> rows = [
      csvHeader,
      _accessToMemoryRepositoryRow,
      for (final classe in _repository.fetch()) toCsv(classe)
    ];
    return const ListToCsvConverter().convert(rows);
  }

  /// Prepares the csv file and starts the download
  Future<void> downloadCsvFile() async {
    final outputFileName = '$fileName.csv';
    final csv = await _databaseToCsv();

    final bytes = convert.utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..type = 'text/csv;charset=utf-8'
      ..download = outputFileName;

    html.document.body.children.add(anchor);

    // download file
    anchor.click();

    // cleanup
    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}

class AccessToMemoryMetadata {
  AccessToMemoryMetadata(
    this.classe, {
    this.repository = '',
  }) : assert(classe != null);

  final Classe classe;
  final String repository;

  final scopeAndContent = <String>[];
  final arrangement = <String>[];
  final appraisal = <String>[];

  List<String> convert(HiveRepository _repository) {
    mapMetadadosToMetadata();
    return <String>[
      _repository.buildReferenceCode(classe),
      repository,
      classe.id.toString(),
      classe.parentId.toString(),
      classe.code,
      classe.name,
      scopeAndContent.join('\n\n'),
      arrangement.join('\n\n'),
      appraisal.join('\n\n'),
    ];
  }

  void mapMetadadosToMetadata() {
    for (final md in classe.metadata.entries) {
      final eArqBrasilType = md.key;
      final content = md.value;
      final atomType = mapEArqBrasilToAtom(eArqBrasilType);
      switch (atomType) {
        case 'scopeAndContent':
          scopeAndContent.add('$eArqBrasilType: $content');
          break;
        case 'arrangement':
          arrangement.add('$eArqBrasilType: $content');
          break;
        case 'appraisal':
          appraisal.add('$eArqBrasilType: $content');
          break;
        default:
          throw UnimplementedError();
      }
    }
  }

  String mapEArqBrasilToAtom(String type) {
    return {
      'Registro de Abertura': 'scopeAndContent',
      'Registro de Desativação': 'scopeAndContent',
      'Reativação da Classe': 'arrangement',
      'Registro de Mudança de Nome de Classe': 'arrangement',
      'Registro de Deslocamento de Classe': 'arrangement',
      'Registro de Extinção': 'arrangement',
      'Indicador de Classe Ativa/Inativa': 'scopeAndContent',
      'Prazo de Guarda na Fase Corrente': 'appraisal',
      'Evento que Determina a Contagem do Prazo de Guarda na Fase Corrente':
          'appraisal',
      'Prazo de Guarda na Fase Intermediária': 'appraisal',
      'Evento que Determina a Contagem do Prazo de Guarda na Fase Intermediária':
          'appraisal',
      'Destinação Final': 'appraisal',
      'Registro de Alteração': 'appraisal',
      'Observações': 'appraisal',
    }[type];
  }
}
