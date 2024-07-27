import 'dart:convert' as convert;

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';

import '../entities/classe.dart';
import '../repositories/classes_repository.dart';

/// Export classes as csv to be imported into the software
/// AtoM - AccessToMemory [https://accesstomemory.org]
class CsvExport {
  CsvExport(
    this._repository, {
    required this.codearq,
    required this.fondsArchivistNode,
    this.fileName = 'ElPCD',
  });

  final String codearq;
  final String fondsArchivistNode;
  final String fileName;

  final ClassesRepository _repository;

  /// AtoM Standards
  List<String> get csvHeader => const <String>[
        'repository',
        'legacyId',
        'parentId',
        'identifier',
        'title',
        'scopeAndContent',
        'arrangement',
        'appraisal',
        'archivistNote',
      ];

  /// All classes on the exported classification scheme will become
  /// subordinate to this Fonds when imported by AtoM.
  List<String> get _accessToMemoryFondsRow {
    return [
      codearq,
      _applyIdPrefix(Classe.rootId),
      '',
      codearq,
      codearq,
      '',
      '',
      '',
      fondsArchivistNode,
    ];
  }

  /// Converts classes from the database
  /// into the csv format to be written to a file
  String _databaseToCsv() {
    final rows = [
      csvHeader,
      _accessToMemoryFondsRow,
      for (final classe in _repository.getAllClasses())
        AccessToMemoryMetadata(classe).convert(applyIdPrefix: _applyIdPrefix),
    ];
    return const ListToCsvConverter().convert(rows);
  }

  /// Prepares the csv file and starts the download
  Future<void> downloadCsvFile() async {
    final csv = _databaseToCsv();

    await FileSaver.instance.saveFile(
      name: fileName,
      bytes: convert.utf8.encode(csv),
      ext: 'csv',
      mimeType: MimeType.csv,
    );
  }

  String _applyIdPrefix(int? id) => 'ElPCD_$id';
}

class AccessToMemoryMetadata {
  AccessToMemoryMetadata(this.classe);

  final Classe classe;

  final scopeAndContent = <String>[];
  final arrangement = <String>[];
  final appraisal = <String>[];

  List<String> convert({required String Function(int?) applyIdPrefix}) {
    _mapMetadadosEArqBrasilToAtoMMetadata();
    return <String>[
      '',
      applyIdPrefix(classe.id),
      applyIdPrefix(classe.parentId),
      classe.code,
      classe.name,
      scopeAndContent.join('\n'),
      arrangement.join('\n'),
      appraisal.join('\n'),
      '',
    ];
  }

  /// Takes a list of `kMetadadosEArqBrasil` types and converts it into the
  /// `AtoMMetadata` types,
  void _mapMetadadosEArqBrasilToAtoMMetadata() {
    for (final md in classe.metadata.entries) {
      final eArqBrasilType = md.key;
      final content = md.value;
      _mapEArqBrasilToAtom(eArqBrasilType).add('$eArqBrasilType: $content');
    }
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
