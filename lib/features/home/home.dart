import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/navigator.dart' as navigator;
import '../../localization.dart';
import '../shared/classes_store.dart';
import '../temporality_table/temporality_table.dart';
import 'drawer.dart';
import 'search_classes_button.dart';
import 'tree_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
        leading: const OpenSettingsMenuButton(),
        actions: const [
          ShowTemporalityTableIconButton(),
          SearchClassesButton(),
          AllClassesExpandedToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      floatingActionButton: const CreateClassFloatingActionButton(),
      drawer: const HomeDrawer(),
      body: ClassesTreeView(
        classesStore: context.read<ClassesStore>(),
      ),
    );
  }
}

class OpenSettingsMenuButton extends StatelessWidget {
  const OpenSettingsMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.segment),
      tooltip: AppLocalizations.of(context).settingsButtonText,
      onPressed: () => Scaffold.of(context).openDrawer(),
    );
  }
}

class AllClassesExpandedToggleButton extends StatelessWidget {
  const AllClassesExpandedToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClassesTreeViewController>();

    if (controller.allNodesExpanded) {
      return IconButton(
        icon: const Icon(Icons.unfold_less),
        tooltip: AppLocalizations.of(context).collapseAllClassesButtonText,
        onPressed: controller.collapseAll,
      );
    }

    return IconButton(
      icon: const Icon(Icons.unfold_more),
      tooltip: AppLocalizations.of(context).expandAllClassesButtonText,
      onPressed: controller.expandAll,
    );
  }
}

class CreateClassFloatingActionButton extends StatelessWidget {
  const CreateClassFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        AppLocalizations.of(context).newClassButtonText.toUpperCase(),
      ),
      icon: const Icon(Icons.post_add),
      onPressed: () => navigator.showClassEditor(),
    );
  }
}
