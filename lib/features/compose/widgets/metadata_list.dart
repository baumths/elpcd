import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/compose_bloc.dart';
import '../bloc/metadata_cubit.dart';
import 'metadata_card.dart';

class MetadataSliverList extends StatelessWidget {
  const MetadataSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      data: ListTileThemeData(
        textColor: Theme.of(context).colorScheme.secondary,
      ),
      child: BlocListener<ComposeBloc, ComposeState>(
        listenWhen: (p, c) => p.isEditing != c.isEditing,
        listener: (_, state) {
          context.read<MetadataCubit>().setInitialMetadata(state.metadata);
        },
        child: BlocBuilder<MetadataCubit, Set<MetadataViewModel>>(
          builder: (_, metadata) => SliverList.builder(
            itemCount: metadata.length,
            itemBuilder: (_, index) => MetadataCard(
              key: ValueKey(metadata.elementAt(index).type),
              metadata: metadata.elementAt(index),
            ),
          ),
        ),
      ),
    );
  }
}
