import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../localization.dart';
import '../compose/compose.dart';
import 'widgets/drawer.dart';
import 'widgets/tree_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
        leading: _buildDrawerButton(),
        actions: _buildActions(context),
      ),
      floatingActionButton: _buildFAB(context),
      drawer: const HomeDrawer(),
      body: ClassesTreeView(
        repository: RepositoryProvider.of(context),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final controller = context.watch<TreeviewController>();
    final expanded = controller.allNodesExpanded;
    final l10n = AppLocalizations.of(context);
    return [
      IconButton(
        icon: const Icon(Icons.search),
        tooltip: l10n.findClassTooltipMessage,
        onPressed: null,
      ),
      IconButton(
        icon: Icon(expanded ? Icons.unfold_less : Icons.unfold_more),
        tooltip: expanded
            ? l10n.collapseAllClassesTooltipMessage
            : l10n.expandAllClassesTooltipMessage,
        onPressed: expanded ? controller.collapseAll : controller.expandAll,
      ),
      const SizedBox(width: 8),
    ];
  }

  Widget _buildDrawerButton() {
    return Builder(
      builder: (BuildContext context) => IconButton(
        icon: const Icon(Icons.segment),
        tooltip: AppLocalizations.of(context).settingsButtonText,
        onPressed: Scaffold.of(context).openDrawer,
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(AppLocalizations.of(context).newClassButtonText),
      icon: const Icon(Icons.post_add),
      onPressed: () => Navigator.of(context).pushNamed(ComposeView.routeName),
    );
  }
}
