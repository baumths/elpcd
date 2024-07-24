import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/metadata_cubit.dart';

class MetadataCard extends StatelessWidget {
  const MetadataCard({super.key, required this.metadata});

  final MetadataViewModel metadata;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              metadata.type,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          _MetadataFormField(metadata: metadata),
        ],
      ),
    );
  }
}

class _MetadataFormField extends StatelessWidget {
  const _MetadataFormField({required this.metadata});

  final MetadataViewModel metadata;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: TextFormField(
        autofocus: true,
        maxLines: null,
        initialValue: metadata.content,
        decoration: InputDecoration(
          hintText: 'Metadados não preenchidos serão removidos.',
          suffixIcon: IconButton(
            tooltip: 'Remover',
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<MetadataCubit>().deleteMetadata(metadata);
            },
          ),
        ),
        onChanged: (value) => metadata.content = value.trim(),
      ),
    );
  }
}
