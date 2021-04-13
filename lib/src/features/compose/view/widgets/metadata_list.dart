import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/compose_bloc.dart';
import '../../misc/misc.dart';
import 'widgets.dart';

class MetadataSliverList extends StatelessWidget {
  const MetadataSliverList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComposeBloc, ComposeState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (_, state) {
        context.read<MetadataCubit>().setInitialMetadata(state.metadata);
      },
      child: BlocBuilder<MetadataCubit, Set<MetadataViewModel>>(
        builder: (_, metadata) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => MetadataCard(
                key: ValueKey(metadata.elementAt(index).type),
                metadata: metadata.elementAt(index),
              ),
              childCount: metadata.length,
            ),
          );
        },
      ),
    );
  }
}
