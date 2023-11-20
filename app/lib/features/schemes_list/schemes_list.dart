import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../app/router.dart';
import '/localizations.dart';
import 'new_scheme_button.dart';
import 'scheme_tile.dart';
import 'schemes_list_controller.dart';

class SchemesList extends StatelessWidget {
  const SchemesList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SchemesListController>();
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, _) => switch (state) {
        SchemesListLoading() => const _Loading(),
        SchemesListFailure() => _Failure(failure: state),
        SchemesListSuccess() when state.schemes.isEmpty => const _Empty(),
        SchemesListSuccess() => ListView.builder(
            itemCount: state.schemes.length,
            itemBuilder: (context, index) => SchemeTile(
              scheme: state.schemes[index],
              onTap: () {
                AppRouter.goToSchemeExplorer(context, state.schemes[index]);
              },
            ),
          ),
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
            leading: const Icon(Icons.circle, size: 40),
            title: Text('.' * 100, overflow: TextOverflow.ellipsis),
            trailing: const Skeleton.shade(
              child: Icon(Icons.arrow_right_rounded, size: 32),
            ),
          );
        },
      ),
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure({required this.failure});

  final SchemesListFailure failure;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                // TODO: illustration?
                const Text('🤔', style: TextStyle(fontSize: 96)),
                Tooltip(
                  message: failure.message,
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
              onPressed: () {
                context.read<SchemesListController>().fetchSchemes();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: illustration?
            const Text('📂', style: TextStyle(fontSize: 96)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                context.l10n.noClassificationSchemes,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const NewSchemeButton(),
          ],
        ),
      ),
    );
  }
}
