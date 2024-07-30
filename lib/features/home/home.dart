import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../localization.dart';
import '../../repositories/classes_repository.dart';
import '../app/navigator.dart' as navigator;
import 'widgets/drawer.dart';
import 'widgets/tree_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
        leading: const OpenSettingsMenuButton(),
        actions: const [
          FindClassButton(),
          AllClassesExpandedToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      floatingActionButton: const CreateClassFloatingActionButton(),
      drawer: const HomeDrawer(),
      body: ClassesTreeView(
        repository: RepositoryProvider.of<ClassesRepository>(context),
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

class FindClassButton extends StatelessWidget {
  const FindClassButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      tooltip: AppLocalizations.of(context).findClassTooltipMessage,
      onPressed: null,
    );
  }
}

class AllClassesExpandedToggleButton extends StatelessWidget {
  const AllClassesExpandedToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TreeviewController>();

    if (controller.allNodesExpanded) {
      return IconButton(
        icon: const Icon(Icons.unfold_less),
        tooltip: AppLocalizations.of(context).collapseAllClassesTooltipMessage,
        onPressed: controller.collapseAll,
      );
    }

    return IconButton(
      icon: const Icon(Icons.unfold_more),
      tooltip: AppLocalizations.of(context).expandAllClassesTooltipMessage,
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
