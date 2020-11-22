import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/shared.dart';
import '../../misc/misc.dart';

class MetadadosCard extends StatelessWidget {
  const MetadadosCard({Key key, @required this.metadado}) : super(key: key);

  final MetadataViewModel metadado;

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
              metadado.type,
              style: TextStyle(
                color: context.accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<FormMetadados>().removeMetadado(metadado);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextFormField(
              minLines: 1,
              maxLines: null,
              initialValue: metadado.content,
              decoration: const InputDecoration(
                hintText: 'Metadados em branco serão removidos.',
              ),
              onChanged: (value) => metadado.content = value.trim(),
            ),
          ),
        ],
      ),
    );
  }
}
