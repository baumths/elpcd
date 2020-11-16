import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:elpcd_dart/src/entities/entities.dart';
import '../misc/form_metadados.dart';

class AddMetadados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: make user select from `Metadados`, only one of each can be added
    return Selector<FormMetadados, bool>(
      selector: (_, value) => value.canAddMetadados,
      builder: (context, canAddMetadados, child) {
        return ListTile(
          enabled: canAddMetadados,
          contentPadding: const EdgeInsets.only(left: 24),
          leading: const Icon(Icons.add),
          title: child,
          onTap: () async {
            // TODO: show dialog to choose metadado
            if (canAddMetadados) {
              final Metadados selected = await _metadadosSelector(context);
              if (selected != null) {
                context
                    .read<FormMetadados>()
                    .addMetadado(Metadado(type: selected));
              }
            }
            // TODO: Notify bloc
          },
        );
      },
      child: const Text(
        'Adicionar Metadados',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<Metadados> _metadadosSelector(BuildContext context) async {
    final formMetadados = context.read<FormMetadados>();
    return showDialog<Metadados>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Selecione um Metadado'),
          children: [
            // Only show Metadados that are not present yet
            for (Metadados type in Metadados.values)
              if (!formMetadados.isPresent(type))
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop<Metadados>(context, type);
                  },
                  child: Text(type.asString()),
                )
          ],
        );
      },
    );
  }
}
