import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class RequiredFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Metadados Obrigatórios',
            style: TextStyle(
              color: context.theme.accentColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Código da Classe',
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            minLines: 1,
            maxLines: null,
            decoration: const InputDecoration(
              labelText: 'Nome da Classe',
            ),
          ),
        ],
      ).padding(padding: const EdgeInsets.all(16)),
    );
  }
}
