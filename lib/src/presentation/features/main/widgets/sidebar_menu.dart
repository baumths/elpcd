import 'package:flutter/material.dart';

import '../../../components/sidebar/sidebar.dart';
import '../../menu/settings/settings_view.dart';

enum SidebarMenuAction {
  /// Closed content
  none,

  /// Find Classes
  search,

  /// Export/Import app data
  exim,

  /// User preferences
  settings,
}

class MainSidebarMenu extends StatelessWidget {
  const MainSidebarMenu({
    Key key = const Key('SidebarMenu'),
  }) : super(key: key);

  Widget _contentBuilder(BuildContext _, SidebarMenuAction? action) {
    switch (action) {
      case SidebarMenuAction.search:
        return const Center(
          child: Text('Search', style: TextStyle(color: Colors.white)),
        );
      case SidebarMenuAction.exim:
        return const Center(
          child: Text('EXIM', style: TextStyle(color: Colors.white)),
        );
      case SidebarMenuAction.settings:
        return const SettingsView();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sidebar<SidebarMenuAction>(
      contentBuilder: _contentBuilder,
      topActions: const [
        SidebarActionItem(
          action: SidebarMenuAction.search,
          icon: Icons.search_rounded,
          tooltip: 'Pesquisar Classe',
        ),
        SidebarActionItem(
          action: SidebarMenuAction.exim,
          tooltip: 'Exportar/Importar',
          icon: Icons.import_export_rounded,
        ),
      ],
      bottomActions: const [
        SidebarActionItem(
          action: SidebarMenuAction.settings,
          icon: Icons.settings_rounded,
          tooltip: 'Configurações',
        ),
      ],
    );
  }
}
