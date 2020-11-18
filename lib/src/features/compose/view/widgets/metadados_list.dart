import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../misc/form_metadados.dart';
import 'widgets.dart';

class MetadadosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FormMetadados>(
      builder: (context, formMetadados, _) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: formMetadados.metadados.length,
          itemBuilder: (_, index) {
            return MetadadosCard(metadado: formMetadados.metadados[index]);
          },
        );
      },
    );
  }
}
