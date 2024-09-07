import 'dart:convert' show utf8;

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localization.dart';
import '../../repositories/classes_repository.dart';
import '../class_editor/earq_brasil_metadata.dart';
import '../settings/settings_controller.dart';
import 'atom_isad_csv_builder.dart';

class CsvExportListTile extends StatefulWidget {
  const CsvExportListTile({super.key});

  @override
  State<CsvExportListTile> createState() => _CsvExportListTileState();
}

class _CsvExportListTileState extends State<CsvExportListTile> {
  late AppLocalizations l10n;
  bool isExporting = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(l10n.csvDownloadButtonText),
      trailing: const Icon(Icons.file_download_rounded),
      enabled: !isExporting,
      onTap: export,
    );
  }

  Future<void> export() async {
    if (isExporting) return;

    setState(() {
      isExporting = true;
    });

    final csv = AtomIsadCsvBuilder(
      institutionCode: context.read<SettingsController>().institutionCode,
      fondsArchivistNote: l10n.csvExportFondsArchivistNote,
      metadataLabels: EarqBrasilMetadata.createKeyToLabelMap(l10n),
    ).buildCsv(
      context.read<ClassesRepository>().getAllClasses(),
    );

    await FileSaver.instance.saveFile(
      bytes: utf8.encode(csv),
      name: 'elpcd_atom_crosswalk',
      ext: 'csv',
      mimeType: MimeType.csv,
    );

    isExporting = false;

    if (mounted) {
      setState(() {});
    }
  }
}
