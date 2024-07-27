import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization.dart';
import '../bloc/metadata_cubit.dart';

class AddMetadata extends StatelessWidget {
  const AddMetadata({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.watch<MetadataCubit>().canAddMetadata) {
      return const _AddMetadataButton();
    }
    return const _MetadataDivider();
  }
}

class _AddMetadataButton extends StatelessWidget {
  const _AddMetadataButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.add),
        title: Text(
          AppLocalizations.of(context).addMetadataButtonText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () async {
          final selected = await _metadadosSelector(context);
          if (selected != null && context.mounted) {
            context
                .read<MetadataCubit>()
                .addMetadata(MetadataViewModel(type: selected));
          }
        },
        selected: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }

  Future<String?> _metadadosSelector(BuildContext context) {
    final isPresent = context.read<MetadataCubit>().isPresent;
    return showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(AppLocalizations.of(context).selectAMetadataDialogHeader),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          const Expanded(child: Divider(indent: 12, endIndent: 12)),
          Text(
            AppLocalizations.of(context).additionalMetadataSectionHeader,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
          const Expanded(child: Divider(indent: 12, endIndent: 12)),
        ],
      ),
    );
  }
}
