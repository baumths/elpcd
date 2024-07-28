import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/classe.dart';
import '../../localization.dart';
import '../../repositories/classes_repository.dart';
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
      create: (_) {
        return ComposeBloc(
          context.read<ClassesRepository>(),
        )..add(ComposeStarted(classe));
      },
      child: BlocListener<ComposeBloc, ComposeState>(
        listenWhen: (p, c) => p.status != c.status,
        listener: (_, state) {
          if (state.status == ComposeStatus.success) {
            Navigator.of(context).popUntil(
              ModalRoute.withName(HomeView.routeName),
            );
          }
          if (state.status == ComposeStatus.failure) {
            ShowSnackBar.error(
              context,
              AppLocalizations.of(context).unableToSaveClassSnackbarText,
            );
          }
        },
        child: BlocProvider<MetadataCubit>(
          create: (_) => MetadataCubit(),
          child: const ComposeScaffold(),
        ),
      ),
    );
  }
}

class ComposeScaffold extends StatelessWidget {
  const ComposeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const ComposeHeader(),
        leading: const DismissChangesIconButton(),
      ),
      floatingActionButton: const SaveChangesFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Center(
        child: SizedBox(
          width: 600,
          child: BlocBuilder<ComposeBloc, ComposeState>(
            builder: (_, state) {
              return IgnorePointer(
                ignoring: state.isSaving,
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
}

class DismissChangesIconButton extends StatelessWidget {
  const DismissChangesIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context).cancelButtonText,
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }
}

class SaveChangesFloatingActionButton extends StatelessWidget {
  const SaveChangesFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComposeBloc, ComposeState>(
      buildWhen: (p, c) => p.isSaving != c.isSaving,
      builder: (context, state) {
        if (state.isSaving) {
          return FloatingActionButton(
            onPressed: null,
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
        return FloatingActionButton.extended(
          label: Text(
            AppLocalizations.of(context).saveButtonText.toUpperCase(),
          ),
          icon: const Icon(Icons.check),
          onPressed: () => context
              .read<ComposeBloc>()
              .add(SavePressed(metadata: context.read<MetadataCubit>().state)),
        );
      },
    );
  }
}

class ComposeHeader extends StatelessWidget {
  const ComposeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<ComposeBloc, ComposeState>(
      buildWhen: (p, c) => p.isEditing != c.isEditing,
      builder: (_, state) {
        if (state.isEditing) {
          return Text(l10n.editingClassComposeHeader);
        }
        return Text(l10n.newClassComposeHeader);
      },
    );
  }
}
