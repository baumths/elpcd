import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../compose/compose.dart';
import 'widgets/drawer.dart';
import 'widgets/tree/treeview.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElPCD'),
        leading: _buildDrawerButton(),
        actions: _buildActions(context),
      ),
      floatingActionButton: _buildFAB(context),
      drawer: const HomeDrawer(),
      body: const Treeview(),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final controller = context.watch<TreeviewController>();
    final expanded = controller.allNodesExpanded;
    return [
      const IconButton(
        icon: Icon(Icons.search),
        tooltip: 'Encontrar Classe',
        onPressed: null,
      ),
      IconButton(
        icon: Icon(expanded ? Icons.unfold_less : Icons.unfold_more),
        tooltip: expanded ? 'Recolher Classes' : 'Expandir Classes',
        onPressed: expanded ? controller.collapseAll : controller.expandAll,
      ),
      const SizedBox(width: 8),
    ];
  }

  Widget _buildDrawerButton() {
    return Builder(
      builder: (BuildContext context) => IconButton(
        icon: const Icon(Icons.segment),
        tooltip: 'Configurações',
        onPressed: Scaffold.of(context).openDrawer,
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('NOVA CLASSE'),
      icon: const Icon(Icons.post_add),
      onPressed: () => Navigator.of(context).pushNamed(ComposeView.routeName),
    );
  }
}
