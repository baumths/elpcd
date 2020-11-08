import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';
import 'home.dart';

import '../description/description.dart';
import '../edit/edit.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.watch<HomeController>().scaffoldKey,
      appBar: AppBar(
        title: const Text('ElPCD'),
        leading: this._buildDrawerButton(context),
        actions: this._buildActions(context),
      ),
      floatingActionButton: this._buildFAB(context),
      drawer: HomeDrawer(),
      body: Treeview(),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final controller = context.watch<TreeviewController>();
    final expanded = controller.allNodesExpanded;
    return [
      IconButton(
        icon: const Icon(Icons.open_in_browser),
        splashRadius: 20,
        onPressed: () {
          Navigator.of(context).pushNamed(EditView.routeName);
        },
      ),
      const SizedBox(width: 8),
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
        var controller = context.read<HomeController>();
        controller.openDescription(context, DescriptionController.newClass());
      },
    );
  }
}
