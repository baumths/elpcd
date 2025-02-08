import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../app/navigator.dart' as navigator;
import '../../localization.dart';
import '../../shared/classes_store.dart';
import '../explorer/explorer.dart';
import '../explorer/search_classes_button.dart';
import '../temporality_table/temporality_table.dart';
import 'controller.dart';
import 'sidebar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1200) {
          return const Scaffold(
            body: Row(
              children: [
                DashboardSidebar(),
                Expanded(
                  child: Column(
                    children: [
                      DashboardTopBar(),
                      Divider(height: 0),
                      Expanded(
                        child: DashboardBody(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: const DashboardBody(),
          drawer: const Drawer(child: DashboardSidebarContent()),
          bottomNavigationBar: const DashboardBottomBar(),
          floatingActionButton: IconButton.filledTonal(
            onPressed: () => navigator.showClassEditor(),
            tooltip: AppLocalizations.of(context).newClassButtonText,
            icon: const Icon(LucideIcons.plus),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
        );
      },
    );
  }
}

class DashboardTopBar extends StatelessWidget {
  const DashboardTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(LucideIcons.panelLeft),
              onPressed: () {
                context.read<DashboardController>().toggleSidebar();
              },
            ),
            const Spacer(),
            const SearchClassesButton(),
            IconButton.filledTonal(
              onPressed: () => navigator.showClassEditor(),
              tooltip: AppLocalizations.of(context).newClassButtonText,
              icon: const Icon(LucideIcons.plus),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.read<DashboardController>().selectedTabNotifier,
      builder: (BuildContext context, DashboardTab selectedTab, _) {
        return switch (selectedTab) {
          DashboardTab.classification => ClassesExplorer(
              classesStore: context.read<ClassesStore>(),
            ),
          DashboardTab.temporality => TemporalityTable(
              classesStore: context.read<ClassesStore>(),
            ),
        };
      },
    );
  }
}

class DashboardBottomBar extends StatelessWidget {
  const DashboardBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      padding: EdgeInsetsDirectional.only(start: 16, end: 8),
      child: Row(
        spacing: 8,
        children: [
          DrawerButton(),
          SearchClassesButton(),
        ],
      ),
    );
  }
}
