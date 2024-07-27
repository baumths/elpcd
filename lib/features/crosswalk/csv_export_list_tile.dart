import 'dart:convert' show utf8;

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localization.dart';
import '../../repositories/classes_repository.dart';
import '../settings/settings_controller.dart';
import 'csv_export_service.dart';

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

    final csv = CsvExportService(
      classesRepository: context.read<ClassesRepository>(),
      codearq: context.read<SettingsController>().codearq,
      fondsArchivistNode: l10n.csvExportFondsArchivistNote,
    ).export();

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
