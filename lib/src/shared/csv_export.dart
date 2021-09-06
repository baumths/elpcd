import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';

import '../entities/entities.dart';
import '../repositories/hive_repository.dart';

// ignore_for_file: unsafe_html

//! Refactor into its own feature, this way it would be possible to track
//! progress and display to the user using BloC.
//! And it would be nice to refactor the `downloadCsvFile`, it is too crouded

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
    final rootId = HiveRepository.kRootId.toString();
    return [codearq, codearq, rootId, '', codearq, codearq, '', '', ''];
  }

  // Converts a single classe into a `List<String>` to be "joined" into csv
  List<String> toCsv(Classe classe) {
    final metadata = AccessToMemoryMetadata(
      classe: classe,
      referenceCode: classe.referenceCode(_repository),
    );
    return metadata.convert();
  }

  /// Converts classes from the database
  /// into the csv format to be written to a file
  Future<String> _databaseToCsv() async {
    final rows = [
      csvHeader,
      _accessToMemoryRepositoryRow,
      for (final classe in _repository.fetch()) toCsv(classe)
    ];
    return const ListToCsvConverter().convert(rows);
  }

  /// Prepares the csv file and starts the download
  Future<void> downloadCsvFile() async {
    final csv = await _databaseToCsv();

    await FileSaver.instance.saveFile(
      '$fileName',
      convert.utf8.encode(csv) as Uint8List,
      'csv',
      mimeType: MimeType.CSV,
    );
  }
}

class AccessToMemoryMetadata {
  AccessToMemoryMetadata({
    required this.classe,
    required this.referenceCode,
  });

  final Classe classe;
  final String referenceCode;

  final scopeAndContent = <String>[];
  final arrangement = <String>[];
  final appraisal = <String>[];

  List<String> convert() {
    _mapMetadadosEArqBrasilToAtoMMetadata();
    return <String>[
      referenceCode,
      '',
      classe.id.toString(),
      classe.parentId.toString(),
      classe.code,
      classe.name,
      scopeAndContent.join('\n'),
      arrangement.join('\n'),
      appraisal.join('\n'),
    ];
  }

  /// Takes a list of `kMetadadosEArqBrasil` types and converts it into the
  /// `AtoMMetadata` types,
  void _mapMetadadosEArqBrasilToAtoMMetadata() {
    classe.metadata.entries.forEach((md) {
      final eArqBrasilType = md.key;
      final content = md.value;
      _mapEArqBrasilToAtom(eArqBrasilType).add('$eArqBrasilType: $content');
    });
  }

  /// Takes a `kMetadadosEArqBrasil` type and returns
  /// the list its content belongs to in `AtoMMetadata` types
  List<String> _mapEArqBrasilToAtom(String type) {
    return {
      'Registro de Abertura': scopeAndContent,
      'Registro de Desativação': scopeAndContent,
      'Reativação da Classe': arrangement,
      'Registro de Mudança de Nome de Classe': arrangement,
      'Registro de Deslocamento de Classe': arrangement,
      'Registro de Extinção': arrangement,
      'Indicador de Classe Ativa/Inativa': scopeAndContent,
      'Prazo de Guarda na Fase Corrente': appraisal,
      'Evento que Determina a Contagem do Prazo de Guarda na Fase Corrente':
          appraisal,
      'Prazo de Guarda na Fase Intermediária': appraisal,
      'Evento que Determina a Contagem do Prazo de Guarda na Fase Intermediária':
          appraisal,
      'Destinação Final': appraisal,
      'Registro de Alteração': appraisal,
      'Observações': appraisal,
    }[type]!;
  }
}
