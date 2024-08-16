import 'package:csv/csv.dart' show ListToCsvConverter;

import '../../entities/classe.dart';
import '../class_editor/earq_brasil_metadata.dart';

// An issue was detected when importing into Atom. Having a parentId of 0 leads
// to subclasses being imported as top level archival descriptions instead of
// being subordinate to the class with id 0.
//
// The current [Classe] setup is not great. The root id is set to -1 and class
// ids start at 0. To avoid having to rework the [Classe] entity or to add a
// prefix to all ids, the fonds id is set to 1 and all class ids are increased
// by 2.
//
// Here's an example of the ids before/after:
//       -1                   1
//      /   \    becomes    /   \
//    0      1     ->      2     3
//   /|\     |\           /|\    |\
//  2 3 4    5 6         4 5 6   7 8

// The following key sets are used to map other metadata sets like
// [EarqBrasilMetadata] to their corresponding metadata in AtoM's
// ISAD(G) template.
// These sets are used by [AtomIsadCsvBuilder.collectMetadata] to
// extract the metadata values from [Classe.metadata] into their
// crosswalked fields.

final Set<String> _appraisalKeys = <String>{
  EarqBrasilMetadata.prazoCorrente.key,
  EarqBrasilMetadata.eventoCorrente.key,
  EarqBrasilMetadata.prazoIntermediaria.key,
  EarqBrasilMetadata.eventoIntermediaria.key,
  EarqBrasilMetadata.destinacao.key,
  EarqBrasilMetadata.alteracao.key,
  EarqBrasilMetadata.observacoes.key,
};

final Set<String> _arrangementKeys = <String>{
  EarqBrasilMetadata.reativacao.key,
  EarqBrasilMetadata.mudancaNome.key,
  EarqBrasilMetadata.deslocamento.key,
  EarqBrasilMetadata.extincao.key,
};

final Set<String> _scopeAndContentKeys = <String>{
  EarqBrasilMetadata.abertura.key,
  EarqBrasilMetadata.destinacao.key,
  EarqBrasilMetadata.indicadorAtiva.key,
};

/// Access to Memory's ISAD(G) Archival Description CSV Template. Source:
/// https://wiki.accesstomemory.org/Resources/CSV_templates#AtoM_2.8_CSV_templates
class AtomIsadCsvBuilder {
  const AtomIsadCsvBuilder({
    required this.institutionCode,
    required this.fondsArchivistNode,
  });

  final String institutionCode;
  final String fondsArchivistNode;

  /// Converts the result of [buildTable] to a CSV string.
  String buildCsv(Iterable<Classe> classes) {
    return const ListToCsvConverter().convert(buildTable(classes));
  }

  /// Converts [classes] into a table formatted as a simplified version of
  /// AtoM's ISAD(G) template (omitting unused fields).
  List<List<Object>> buildTable(Iterable<Classe> classes) {
    return <List<Object>>[
      buildHeaderRow(),
      buildFondsRow(),
      ...classes.map(buildClassRow),
    ];
  }

  List<Object> buildHeaderRow() {
    return buildRow(
      repository: 'repository',
      legacyId: 'legacyId',
      parentId: 'parentId',
      identifier: 'identifier',
      title: 'title',
      scopeAndContent: 'scopeAndContent',
      arrangement: 'arrangement',
      appraisal: 'appraisal',
      archivistNote: 'archivistNote',
    );
  }

  /// The top level Archival Description created by AtoM to which all classes
  /// on the exported classification scheme will be subordinate.
  List<Object> buildFondsRow() {
    return buildRow(
      repository: institutionCode,
      legacyId: 1,
      parentId: '',
      identifier: institutionCode,
      title: institutionCode,
      scopeAndContent: '',
      arrangement: '',
      appraisal: '',
      archivistNote: fondsArchivistNode,
    );
  }

  List<Object> buildClassRow(Classe clazz) {
    assert(clazz.id != null, 'All classes must have a non-null id.');
    return buildRow(
      repository: '',
      legacyId: clazz.id! + 2,
      parentId: clazz.parentId + 2,
      identifier: clazz.code,
      title: clazz.name,
      scopeAndContent: collectMetadata(_scopeAndContentKeys, clazz.metadata),
      arrangement: collectMetadata(_arrangementKeys, clazz.metadata),
      appraisal: collectMetadata(_appraisalKeys, clazz.metadata),
      archivistNote: '',
    );
  }

  List<Object> buildRow({
    required Object repository,
    required Object legacyId,
    required Object parentId,
    required Object identifier,
    required Object title,
    required Object scopeAndContent,
    required Object arrangement,
    required Object appraisal,
    required Object archivistNote,
  }) {
    return <Object>[
      repository,
      legacyId,
      parentId,
      identifier,
      title,
      scopeAndContent,
      arrangement,
      appraisal,
      archivistNote,
    ];
  }

  String collectMetadata(Iterable<String> keys, Map<String, String> metadata) {
    if (metadata.isEmpty) {
      return '';
    }
    final buf = StringBuffer();
    for (final String key in keys) {
      if (metadata[key] case final String value?) {
        buf.write(key);
        buf.write(': ');
        buf.writeln(value);
      }
    }
    // The trimRight() is a hack to remove the last newline.
    return buf.toString().trimRight();
  }
}
