import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../misc/misc.dart';

class MetadataCard extends StatelessWidget {
  const MetadataCard({Key key, @required this.metadata}) : super(key: key);

  final MetadataViewModel metadata;

  // TODO: `destinacaoFinal` and `indicador` should be toggle buttons

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Column(
        children: [
          ListTile(
            title: Text(
              metadata.type,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<FormMetadata>().removeMetadata(metadata);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextFormField(
              minLines: 1,
              maxLines: null,
              initialValue: metadata.content,
              decoration: const InputDecoration(
                hintText: 'Metadados não preenchidos serão removidos.',
              ),
              onChanged: (value) => metadata.content = value.trim(),
            ),
          ),
        ],
      ),
    );
  }
}
