import 'package:flutter/material.dart';

import '/localizations.dart';
import '../router.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ConstrainedBox(
          // TODO: update when working on adaptive/responsive layouts
          constraints: const BoxConstraints(maxWidth: 980),
          child: Scaffold(
            appBar: AppBar(
              notificationPredicate: (_) => false,
              title: GestureDetector(
                onTap: () => AppRouter.goToSchemesList(context),
                child: Text(
                  context.l10n.shortAppTitle,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            body: body,
          ),
        ),
      ),
    );
  }
}
