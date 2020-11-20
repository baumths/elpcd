import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../entities/entities.dart';
import '../../../repositories/hive_repository.dart';
import '../../../shared/shared.dart';
import '../../features.dart';
import '../bloc/compose_bloc.dart';
import '../misc/form_metadados.dart';
import 'widgets/widgets.dart';

class ComposeView extends StatelessWidget {
  const ComposeView({Key key, @required this.classe}) : super(key: key);

  static const routeName = '/compose';

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComposeBloc>(
      create: (context) => ComposeBloc(
        RepositoryProvider.of<HiveRepository>(context),
      )..add(ComposeStarted(classe: classe)),
      child: BlocConsumer<ComposeBloc, ComposeState>(
        listenWhen: (p, c) => p.successOrFailure != c.successOrFailure,
        listener: (_, state) {
          if (state.successOrFailure == ComposeSuccessOrFailure.success) {
            Navigator.of(context).popUntil(
              (route) => route.settings.name == HomeView.routeName,
            );
          }
          if (state.successOrFailure == ComposeSuccessOrFailure.failure) {
            ShowSnackBar.error(context, 'Não foi possível salvar a Classe');
          }
        },
        buildWhen: (p, c) => p.isSaving != c.isSaving,
        builder: (_, state) => _ComposeViewScaffold(isSaving: state.isSaving),
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
    return ChangeNotifierProvider(
      create: (_) => FormMetadados(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<ComposeBloc, ComposeState>(
            buildWhen: (p, c) => p.isEditing != c.isEditing,
            builder: (_, state) {
              return Text(state.isEditing ? 'Editando Classe' : 'Nova Classe');
            },
          ),
          actions: [
            IconButton(
              tooltip: 'Salvar',
              icon: const Icon(Icons.check),
              onPressed: () => context.read<ComposeBloc>().add(SavePressed(
                  metadados: context.read<FormMetadados>().metadados)),
            )
          ],
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: IgnorePointer(
            ignoring: isSaving,
            child: Scrollbar(
              radius: const Radius.circular(8),
              child: CustomScrollView(
                slivers: [
                  if (isSaving) const LinearProgressIndicator(),
                  SliverToBoxAdapter(child: RequiredFields()),
                  SliverToBoxAdapter(child: MetadadosList()),
                  SliverToBoxAdapter(child: AddMetadados()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
