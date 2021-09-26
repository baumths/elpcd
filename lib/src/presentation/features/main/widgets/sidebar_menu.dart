import 'package:flutter/material.dart';

import '../../../components/sidebar/sidebar.dart';
import '../../menu/settings/settings_view.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({
    Key key = const Key('SidebarMenu'),
  }) : super(key: key);

  Widget _contentBuilder(BuildContext _, SidebarAction action) {
    switch (action) {
      case SidebarAction.none:
        return const SizedBox();
      case SidebarAction.search:
        return const Center(
          child: Text('Search', style: TextStyle(color: Colors.white)),
        );
      case SidebarAction.exim:
        return const Center(
          child: Text('EXIM', style: TextStyle(color: Colors.white)),
        );
      case SidebarAction.settings:
        return const SettingsView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sidebar(
      topActions: const <SidebarActionItem>[
        SidebarActionItem(
          action: SidebarAction.search,
          icon: Icons.search_rounded,
          tooltip: 'Pesquisar Classe',
        ),
        SidebarActionItem(
          action: SidebarAction.exim,
          tooltip: 'Exportar/Importar',
          icon: Icons.import_export_rounded,
        ),
      ],
      bottomActions: const <SidebarActionItem>[
        SidebarActionItem(
          action: SidebarAction.settings,
          icon: Icons.settings_rounded,
          tooltip: 'Configurações',
        ),
      ],
      contentBuilder: _contentBuilder,
    );
  }
}
