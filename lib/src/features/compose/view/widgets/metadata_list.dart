import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../bloc/compose_bloc.dart';
import '../../misc/misc.dart';
import 'widgets.dart';

class MetadataList extends StatelessWidget {
  const MetadataList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComposeBloc, ComposeState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (_, state) {
        context.read<FormMetadata>().setInitialMetadata(state.metadata);
      },
      child: Consumer<FormMetadata>(
        builder: (_, formMetadata, __) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: formMetadata.metadata.length,
            itemBuilder: (_, index) {
              return MetadataCard(
                metadata: formMetadata.metadata.elementAt(index),
              );
            },
          );
        },
      ),
    );
  }
}
