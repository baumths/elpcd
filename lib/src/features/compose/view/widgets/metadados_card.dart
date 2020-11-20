import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../entities/entities.dart';
import '../../../../shared/shared.dart';
import '../../misc/form_metadados.dart';

class MetadadosCard extends StatelessWidget {
  const MetadadosCard({Key key, @required this.metadado}) : super(key: key);

  final Metadado metadado;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Column(
        children: [
          ListTile(
            // contentPadding: const EdgeInsets.symmetric(horizontal: 4),
            title: Text(
              metadado.label,
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
              autofocus: true,
              initialValue: metadado.content,
              decoration: InputDecoration(hintText: metadado.label),
              onChanged: (value) => metadado.content = value.trim(),
            ),
          ),
        ],
      ),
    );
  }
}
