part of '../transfer.dart';

class CsvExportSection extends StatelessWidget {
  const CsvExportSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransferSection(
      content: const SectionContent(
        icon: Icons.file_download_outlined,
        title: 'Exportar CSV',
        description: 'O arquivo exportado poderá ser importado '
            'pelo software livre AtoM (ICA-AtoM).',
      ),
      action: StretchedButton(
        child: const Text('GERAR ARQUIVO'),
        height: 40,
        onPressed: () {
          // TODO: Show modal of csv file generation with download button
          // Modal COULD be a table of all classes with checkbox to select which
          // classes should be included in the export. Starts with all selected.
        },
      ),
    );
  }
}
