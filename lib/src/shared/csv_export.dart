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
  List<String> get csvHeader => [
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
    return metadata.convert();
  }

  /// Converts classes from the database
  /// into the csv format to be written to a file
  Future<String> _databaseToCsv() async {
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

  List<String> scopeAndContent;
  List<String> arrangement;
  List<String> appraisal;

  List<String> convert() {
    mapMetadadosToMetadata();
    return <String>[
      classe.referenceCode,
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
    for (final metadado in classe.metadados) {
      switch (metadado.type) {
        case Metadados.registroAbertura:
        case Metadados.registroDesativacao:
        case Metadados.indicador:
          scopeAndContent.add(metadado.toCsv());
          break;
        case Metadados.registroReativacao:
        case Metadados.registroMudancaNome:
        case Metadados.registroDeslocamento:
        case Metadados.registroExtincao:
          arrangement.add(metadado.toCsv());
          break;
        case Metadados.prazoCorrente:
        case Metadados.eventoCorrente:
        case Metadados.prazoIntermediaria:
        case Metadados.eventoIntermediaria:
        case Metadados.destinacaoFinal:
        case Metadados.registroAlteracao:
        case Metadados.observacoes:
          appraisal.add(metadado.toCsv());
          break;
        default:
          throw UnimplementedError();
      }
    }
  }
}
