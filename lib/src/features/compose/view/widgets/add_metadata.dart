import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../misc/misc.dart';

class AddMetadata extends StatelessWidget {
  const AddMetadata({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canAddMetadata = context.watch<MetadataCubit>().canAddMetadata;
    return ListTile(
      enabled: canAddMetadata,
      minLeadingWidth: 10,
      contentPadding: const EdgeInsets.only(left: 24),
      leading: const Icon(Icons.add),
      dense: true,
      subtitle: const Text('Metadados não preenchidos serão removidos.'),
      title: const Text(
        'Adicionar Metadados',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () async {
        if (canAddMetadata) {
          final String selected = await _metadadosSelector(context);
          if (selected != null) {
            context
                .read<MetadataCubit>()
                .addMetadata(MetadataViewModel(type: selected));
          }
        }
        // TODO: Notify bloc
      },
    );
  }

  Future<String> _metadadosSelector(BuildContext context) {
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
