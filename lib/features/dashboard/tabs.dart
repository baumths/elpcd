import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../localization.dart';
import 'controller.dart';

class DashboardTabList extends StatelessWidget {
  const DashboardTabList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = context.read<DashboardController>();

    void selectTab(DashboardTab tab) {
      if (Scaffold.of(context) case final scaffold
          when scaffold.hasDrawer && scaffold.isDrawerOpen) {
        scaffold.closeDrawer();
      }
      controller.selectTab(tab);
    }

    return ValueListenableBuilder(
      valueListenable: controller.selectedTabNotifier,
      builder: (BuildContext context, DashboardTab selectedTab, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DashboardTabTile(
              icon: LucideIcons.listTree,
              label: l10n.dashboardTabClassificationSchemeLabel,
              isSelected: selectedTab == DashboardTab.classification,
              onPressed: () => selectTab(DashboardTab.classification),
            ),
            const SizedBox(height: 4),
            DashboardTabTile(
              icon: LucideIcons.table2,
              label: l10n.dashboardTabTemporalityTableLabel,
              isSelected: selectedTab == DashboardTab.temporality,
              onPressed: () => selectTab(DashboardTab.temporality),
            )
          ],
        );
      },
    );
  }
}

class DashboardTabTile extends StatelessWidget {
  const DashboardTabTile({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    late Color backgroundColor;
    late Color foregroundColor;

    if (isSelected) {
      backgroundColor = theme.colorScheme.surfaceContainerHighest;
      foregroundColor = theme.colorScheme.onSurface;
    } else {
      backgroundColor = Colors.transparent;
      foregroundColor = theme.colorScheme.onSurfaceVariant;
    }

    return Material(
      color: backgroundColor,
      textStyle: theme.textTheme.labelLarge?.copyWith(color: foregroundColor),
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 36,
            child: Row(
              spacing: 8,
              children: [
                Icon(icon, size: 20, color: foregroundColor),
                Flexible(child: Text(label)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
