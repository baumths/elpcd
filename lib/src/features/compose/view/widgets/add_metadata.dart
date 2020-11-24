import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../misc/misc.dart';

class AddMetadata extends StatelessWidget {
  const AddMetadata({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<FormMetadata, bool>(
      selector: (_, value) => value.canAddMetadata,
      builder: (_, canAddMetadata, child) {
        return ListTile(
          enabled: canAddMetadata,
          minLeadingWidth: 10,
          contentPadding: const EdgeInsets.only(left: 24),
          leading: const Icon(Icons.add),
          dense: true,
          subtitle: const Text('Metadados não preenchidos serão removidos.'),
          title: child,
          onTap: () async {
            if (canAddMetadata) {
              final String selected = await _metadadosSelector(context);
              if (selected != null) {
                context
                    .read<FormMetadata>()
                    .addMetadata(MetadataViewModel(type: selected));
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
    final formMetadados = context.read<FormMetadata>();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Selecione um Metadado'),
          children: [
            for (String type in kMetadadosEArqBrasil)
              if (!formMetadados.isPresent(type))
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
