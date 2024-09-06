import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/navigator.dart' as navigator;
import '../../localization.dart';
import '../../shared/classes_store.dart';
import '../explorer/explorer.dart';
import '../explorer/search_classes_button.dart';
import '../temporality_table/temporality_table.dart';
import 'drawer.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
        leading: const OpenDashboardDrawerButton(),
        actions: const [DashboardActionButtons(), SizedBox(width: 8)],
      ),
      floatingActionButton: const CreateClassFloatingActionButton(),
      drawer: const DashboardDrawer(),
      body: ClassesExplorer(
        classesStore: context.read<ClassesStore>(),
      ),
    );
  }
}

class OpenDashboardDrawerButton extends StatelessWidget {
  const OpenDashboardDrawerButton({super.key});

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
      onPressed: () => navigator.showClassEditor(),
      icon: const Icon(Icons.add),
      label: Text(
        AppLocalizations.of(context).newClassButtonText.toUpperCase(),
      ),
    );
  }
}

class DashboardActionButtons extends StatelessWidget {
  const DashboardActionButtons({super.key});

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
