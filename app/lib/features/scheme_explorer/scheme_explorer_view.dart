import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/localizations.dart';
import '/shared/widgets/elevated_box.dart';
import '/shared/widgets/focus_driven_text_field.dart';
import 'scheme_explorer_controller.dart';

class SchemeExplorerView extends StatelessWidget {
  const SchemeExplorerView({super.key, this.schemeId});

  final String? schemeId;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => SchemeExplorerController(
        classesRepository: context.read(),
      )..loadScheme(schemeId),
      dispose: (_, controller) => controller.dispose(),
      child: const Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
        child: SchemeExplorerContent(),
      ),
    );
  }
}

class SchemeExplorerContent extends StatelessWidget {
  const SchemeExplorerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SchemeExplorerController>();
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, _) => switch (state) {
        SchemeExplorerInitial() || SchemeExplorerLoading() => const _Loading(),
        SchemeExplorerFailure() => _Failure(failure: state),
        SchemeExplorerSuccess() => _Success(state: state),
      },
    );
  }
}

// TODO(feature): make failures more informative
class _Failure extends StatelessWidget {
  const _Failure({required this.failure});

  final SchemeExplorerFailure failure;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final failureMessage = switch (failure) {
      SchemeIdNotFound() => 'Scheme ${failure.schemeId} not found'.unlocalized,
      InvalidSchemeId() => 'Invalid Scheme id: ${failure.schemeId}'.unlocalized,
      DatabaseFailure f => 'Database failure: ${f.exception}'.unlocalized,
    };

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                // TODO(feature): illustration?
                const Text('🤔', style: TextStyle(fontSize: 96)),
                Tooltip(
                  message: failureMessage,
                  child: Icon(
                    Icons.warning_rounded,
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ),
            Text(
              context.l10n.somethingWentWrong,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              child: Text(context.l10n.tryAgain),
              onPressed: () => context
                  .read<SchemeExplorerController>()
                  .loadScheme(failure.schemeId),
            ),
          ],
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    // TODO(chore): Use [Skeletonizer] instead of [CircularProgressIndicator]
    return const SizedBox.expand(
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

class _Success extends StatelessWidget {
  const _Success({required this.state});

  final SchemeExplorerSuccess state;

  @override
  Widget build(BuildContext context) {
    return Provider<SchemeExplorerSuccess>.value(
      value: state,
      child: const Column(
        children: [
          SchemeExplorerHeader(),
          SizedBox(height: 8),
          Expanded(
            child: ElevatedBox(
              // TODO(feature): Classes Hierarchy
              child: Placeholder(),
            ),
          ),
        ],
      ),
    );
  }
}

class SchemeExplorerHeader extends StatelessWidget {
  const SchemeExplorerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SchemeTitle()),
        const SizedBox(width: 8),
        FilledButton(
          child: Text(context.l10n.newClass),
          onPressed: () {
            // TODO(feature): show new class input field
          },
        )
      ],
    );
  }
}

class SchemeTitle extends StatelessWidget {
  const SchemeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = context.watch<SchemeExplorerSuccess>().scheme;
    return FocusDrivenTextField(
      initialText: scheme.name.isEmpty ? context.l10n.untitled : scheme.name,
      onLostFocus: (name) {
        context.read<SchemeExplorerController>().updateSchemeName(name);
      },
    );
  }
}
