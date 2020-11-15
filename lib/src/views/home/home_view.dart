import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/shared.dart';
import '../views.dart';
import 'widgets/widgets.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.watch<HomeController>().scaffoldKey,
      appBar: AppBar(
        title: const Text('ElPCD'),
        leading: _buildDrawerButton(context),
        actions: _buildActions(context),
      ),
      floatingActionButton: _buildFAB(context),
      drawer: HomeDrawer(),
      body: Treeview(),
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

  Widget _buildDrawerButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.segment),
      tooltip: 'Configurações',
      splashRadius: 24,
      onPressed: () {
        context.read<HomeController>().scaffold.openDrawer();
      },
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      hoverColor: Colors.white10,
      label: const Text('NOVA CLASSE'),
      icon: const Icon(Icons.post_add),
      onPressed: () {
        // TODO: push to create class route
        context.display(DescriptionView(DescriptionController.newClass()));
      },
    );
  }
}
