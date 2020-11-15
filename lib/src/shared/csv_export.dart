import 'dart:convert' as convert;

import 'package:csv/csv.dart';
import 'package:universal_html/html.dart' as html;

import '../database/hive_database.dart';

/// Export classes as csv to be imported into the software
/// AtoM - AccessToMemory [https://accesstomemory.org]
class CsvExport {
  CsvExport({this.fileName = 'ElPCD'});

  final String fileName;

  /// AtoM Standards
  List<String> get _csvColumns => [
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
  List<String> get _repositoryRow {
    final String codearq = HiveDatabase.settingsBox.get(
      'codearq',
      defaultValue: 'ElPCD',
    ) as String;
    return [codearq, codearq, '-1', '', codearq, codearq, '', '', ''];
  }

  /// Converts classes from the database
  /// into the csv format to be written to a file
  Future<String> _databaseToCsv() async {
    final List<List<String>> rows = [_csvColumns, _repositoryRow];
    // ignore: avoid_function_literals_in_foreach_calls
    HiveDatabase.pcdBox.values.forEach((pcd) {
      if (pcd != null) rows.add(pcd.toCsv());
    });
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
