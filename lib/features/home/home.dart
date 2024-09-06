import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/navigator.dart' as navigator;
import '../../localization.dart';
import '../../shared/classes_store.dart';
import '../explorer/explorer.dart';
import '../explorer/search_classes_button.dart';
import '../temporality_table/temporality_table.dart';
import 'drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
        leading: const OpenSettingsMenuButton(),
        actions: const [HomeActionButtons(), SizedBox(width: 8)],
      ),
      floatingActionButton: const CreateClassFloatingActionButton(),
      drawer: const HomeDrawer(),
      body: ClassesExplorer(
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

class HomeActionButtons extends StatelessWidget {
  const HomeActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final bool hasClasses = context.select<ClassesStore, bool>(
      (ClassesStore store) => !store.isEmpty,
    );

    if (hasClasses) {
      return const Row(
        children: [
          ShowTemporalityTableIconButton(),
          SearchClassesButton(),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
