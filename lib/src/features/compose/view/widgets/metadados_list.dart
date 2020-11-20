import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../bloc/compose_bloc.dart';
import '../../misc/form_metadados.dart';
import 'widgets.dart';

class MetadadosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ComposeBloc, ComposeState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (_, state) {
        context.read<FormMetadados>().setInitialMetadados(state.metadados);
      },
      child: Consumer<FormMetadados>(
        builder: (_, formMetadados, __) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: formMetadados.metadados.length,
            itemBuilder: (_, index) {
              return MetadadosCard(
                metadado: formMetadados.metadados.elementAt(index),
              );
            },
          );
        },
      ),
    );
  }
}
