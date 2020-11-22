import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../misc/misc.dart';

class AddMetadados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: make user select from `MetadataType`, only one of each can be added
    return Selector<FormMetadados, bool>(
      selector: (_, value) => value.canAddMetadados,
      builder: (_, canAddMetadados, child) {
        return ListTile(
          enabled: canAddMetadados,
          contentPadding: const EdgeInsets.only(left: 24),
          leading: const Icon(Icons.add),
          title: child,
          onTap: () async {
            // TODO: show dialog to choose metadado
            if (canAddMetadados) {
              final String selected = await _metadadosSelector(context);
              if (selected != null) {
                context
                    .read<FormMetadados>()
                    .addMetadado(MetadataViewModel(type: selected));
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

  Future<String> _metadadosSelector(BuildContext context) async {
    final formMetadados = context.read<FormMetadados>();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Selecione um Metadado'),
          children: [
            for (String type in kMetadadosEArqBrasil)
              if (!formMetadados.isPresent(type))
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop<String>(context, type);
                  },
                  child: Text(type),
                )
          ],
        );
      },
    );
  }
}
