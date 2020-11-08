import 'package:universal_html/html.dart' as html;
import 'dart:convert' as convert;

import 'package:csv/csv.dart';

import 'package:elpcd_dart/src/database/hive_database.dart';

/// Export classes as csv to be imported into the software
/// AtoM - AccessToMemory [https://accesstomemory.org]
class CsvExport {
  CsvExport({this.fileName});

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
    String codearq = HiveDatabase.settingsBox.get(
      'codearq',
      defaultValue: 'ElPCD',
    );
    return [codearq, codearq, '-1', '', codearq, codearq, '', '', ''];
  }

  /// Converts classes from the database
  /// into the csv format to be written to a file
  Future<String> _databaseToCsv() async {
    List<List<String>> rows = [this._csvColumns, this._repositoryRow];
    HiveDatabase.pcdBox.values.forEach((pcd) {
      if (pcd != null) rows.add(pcd.toCsv());
    });
    return ListToCsvConverter().convert(rows);
  }

  /// Prepares the csv file and starts the download
  void downloadCsvFile() async {
    final outputFileName = this.fileName ?? 'ElPCD' + '.csv';
    final csv = await this._databaseToCsv();

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
