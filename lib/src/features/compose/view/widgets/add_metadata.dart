import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../misc/misc.dart';

class AddMetadata extends StatelessWidget {
  const AddMetadata({super.key});

  @override
  Widget build(BuildContext context) {
    final canAddMetadata = context.watch<MetadataCubit>().canAddMetadata;

    return Center(
      child: SizedBox(
        width: 600,
        child: canAddMetadata
            ? const _AddMetadataButton()
            : const _MetadataDivider(),
      ),
    );
  }
}

class _AddMetadataButton extends StatelessWidget {
  const _AddMetadataButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.brightness == Brightness.dark
        ? theme.colorScheme.secondary
        : theme.colorScheme.primary;

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 4, 24, 0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        minLeadingWidth: 10,
        contentPadding: const EdgeInsets.only(left: 24),
        leading: Icon(Icons.add, color: color),
        title: Text(
          'Adicionar Metadados',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        onTap: () async {
          final selected = await _metadadosSelector(context);
          if (selected != null && context.mounted) {
            context
                .read<MetadataCubit>()
                .addMetadata(MetadataViewModel(type: selected));
          }
        },
      ),
    );
  }

  Future<String?> _metadadosSelector(BuildContext context) {
    final isPresent = context.read<MetadataCubit>().isPresent;
    return showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Selecione um Metadado'),
          children: [
            for (final type in kMetadadosEArqBrasil)
              if (!isPresent(type))
                SimpleDialogOption(
                  onPressed: () => Navigator.pop<String>(context, type),
                  child: Text(type),
                )
          ],
        );
      },
    );
  }
}

class _MetadataDivider extends StatelessWidget {
  const _MetadataDivider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.brightness == Brightness.dark
        ? theme.colorScheme.secondary
        : theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: Container(color: color, height: 1)),
          const SizedBox(width: 4),
          Text(
            'Metadados Adicionais',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(width: 4),
          Expanded(child: Container(color: color, height: 1)),
        ],
      ),
    );
  }
}
