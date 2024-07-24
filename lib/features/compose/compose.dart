import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/classe.dart';
import '../../repositories/hive_repository.dart';
import '../../shared/show_snackbar.dart';
import '../home/home.dart';
import 'bloc/compose_bloc.dart';
import 'bloc/metadata_cubit.dart';
import 'widgets/add_metadata.dart';
import 'widgets/metadata_list.dart';
import 'widgets/required_fields.dart';

class ComposeView extends StatelessWidget {
  const ComposeView({super.key});

  static const routeName = '/compose';

  @override
  Widget build(BuildContext context) {
    final classe = ModalRoute.of(context)!.settings.arguments as Classe?;

    return BlocProvider<ComposeBloc>(
      create: (_) => ComposeBloc(
        RepositoryProvider.of<HiveRepository>(context),
      )..add(
          ComposeStarted(classe),
        ),
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
  const _ComposeViewScaffold({required this.isSaving});

  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: BlocBuilder<ComposeBloc, ComposeState>(
          buildWhen: (p, c) => p.isEditing != c.isEditing,
          builder: (_, state) {
            return Text(state.isEditing ? 'Editando Classe' : 'Nova Classe');
          },
        ),
        leading: _leading(context),
      ),
      floatingActionButton: _floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Center(
        child: SizedBox(
          width: 600,
          child: BlocBuilder<ComposeBloc, ComposeState>(
            builder: (_, state) {
              return IgnorePointer(
                ignoring: isSaving,
                child: const CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: SizedBox(height: 24)),
                    SliverToBoxAdapter(child: RequiredFields()),
                    SliverToBoxAdapter(child: AddMetadata()),
                    MetadataSliverList(),
                    SliverToBoxAdapter(child: SizedBox(height: 240)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  IconButton _leading(BuildContext context) {
    return IconButton(
      tooltip: 'Cancelar',
      icon: const Icon(Icons.arrow_back),
      onPressed: Navigator.of(context).pop,
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context) {
    if (isSaving) {
      return FloatingActionButton(
        onPressed: null,
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }
    return FloatingActionButton.extended(
      label: const Text('SALVAR'),
      icon: const Icon(Icons.check),
      onPressed: () => context
          .read<ComposeBloc>()
          .add(SavePressed(metadata: context.read<MetadataCubit>().state)),
    );
  }
}
