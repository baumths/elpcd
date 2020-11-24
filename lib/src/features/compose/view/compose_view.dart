import 'package:elpcd_dart/src/features/compose/misc/misc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../entities/entities.dart';
import '../../../repositories/hive_repository.dart';
import '../../../shared/shared.dart';
import '../../features.dart';
import '../bloc/compose_bloc.dart';
import 'widgets/widgets.dart';

class ComposeView extends StatelessWidget {
  const ComposeView({Key key}) : super(key: key);

  static const routeName = '/compose';

  @override
  Widget build(BuildContext context) {
    final classe = ModalRoute.of(context).settings.arguments as Classe;

    return BlocProvider<ComposeBloc>(
      create: (_) => ComposeBloc(
        RepositoryProvider.of<HiveRepository>(context),
      )..add(ComposeStarted(classe: classe)),
      child: BlocConsumer<ComposeBloc, ComposeState>(
        listenWhen: (p, c) => p.status != c.status,
        listener: (_, state) {
          if (state.status == ComposeStatus.success) {
            Navigator.of(context).popUntil(
              ModalRoute.withName(HomeView.routeName),
            );
          }
          if (state.status == ComposeStatus.failure) {
            ShowSnackBar.error(context, 'Não foi possível salvar a Classe');
          }
        },
        buildWhen: (p, c) => p.isSaving != c.isSaving,
        builder: (_, state) {
          return BlocProvider<MetadataCubit>(
            create: (_) => MetadataCubit(),
            child: _ComposeViewScaffold(isSaving: state.isSaving),
          );
        },
      ),
    );
  }
}

class _ComposeViewScaffold extends StatelessWidget {
  const _ComposeViewScaffold({
    Key key,
    @required this.isSaving,
  }) : super(key: key);

  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ComposeBloc, ComposeState>(
          buildWhen: (p, c) => p.isEditing != c.isEditing,
          builder: (_, state) {
            return Text(state.isEditing ? 'Editando Classe' : 'Nova Classe');
          },
        ),
        leading: _leading(context),
        actions: _actions(context),
      ),
      body: BlocBuilder<ComposeBloc, ComposeState>(
        builder: (_, state) {
          return IgnorePointer(
            ignoring: isSaving,
            child: Scrollbar(
              radius: const Radius.circular(8),
              child: CustomScrollView(
                slivers: [
                  if (isSaving)
                    const SliverToBoxAdapter(
                      child: LinearProgressIndicator(),
                    ),
                  const SliverToBoxAdapter(child: RequiredFields()),
                  const SliverToBoxAdapter(child: AddMetadata()),
                  const MetadataSliverList(),
                  const SliverToBoxAdapter(child: SizedBox(height: 240)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _actions(BuildContext context) {
    return <Widget>[
      IconButton(
        splashRadius: 20,
        tooltip: 'Salvar',
        icon: const Icon(Icons.check),
        onPressed: () => context
            .read<ComposeBloc>()
            .add(SavePressed(metadata: context.read<MetadataCubit>().state)),
      ),
      const SizedBox(width: 8),
    ];
  }

  IconButton _leading(BuildContext context) {
    return IconButton(
      tooltip: 'Cancelar',
      splashRadius: 20,
      icon: const Icon(Icons.arrow_back),
      onPressed: Navigator.of(context).pop,
    );
  }
}
