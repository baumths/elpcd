import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features.dart';
import 'widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);
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
        splashRadius: 20,
        onPressed: null,
      ),
      IconButton(
        splashRadius: 20,
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
        splashRadius: 24,
        onPressed: Scaffold.of(context).openDrawer,
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      hoverColor: Colors.white10,
      label: const Text('NOVA CLASSE'),
      icon: const Icon(Icons.post_add),
      onPressed: () => Navigator.of(context).pushNamed(ComposeView.routeName),
    );
  }
}
