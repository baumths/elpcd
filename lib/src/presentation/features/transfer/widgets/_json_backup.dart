part of '../transfer.dart';

class JsonBackupSection extends StatelessWidget {
  const JsonBackupSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransferSection(
      content: const SectionContent(
        icon: Icons.backup_outlined,
        title: 'Backup JSON',
        description: 'Os arquivos JSON gerados podem ser utilizados para '
            'salvar um backup de segurança ou também como uma forma '
            'de compartilhar o seu PCD.',
      ),
      action: Row(
        children: [
          Flexible(
            child: StretchedButton(
              child: const Text('IMPORTAR'),
              onPressed: () {
                // TODO: Show modal to drop/select JSON file
              },
              height: 40,
            ),
          ),
          const SizedBox(width: AppInsets.medium),
          Flexible(
            child: StretchedButton(
              child: const Text('EXPORTAR'),
              onPressed: () {
                // TODO: Show modal of file generation progress
              },
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
