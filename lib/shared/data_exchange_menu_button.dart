import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../localization.dart';
import 'data_exchange_handlers.dart';

class DataExchangeMenuButton extends StatelessWidget {
  const DataExchangeMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return MenuAnchor(
      alignmentOffset: const Offset(0, 4),
      menuChildren: [
        MenuItemButton(
          onPressed: () => handleAtomIsadCsvExport(context),
          leadingIcon: const Icon(LucideIcons.arrowUpRight),
          child: Text(l10n.exportAtomIsadCsvButtonText),
        ),
        MenuItemButton(
          onPressed: () => handleJsonBackupExport(context),
          leadingIcon: const Icon(LucideIcons.cloudUpload),
          child: Text(l10n.exportBackupButtonText),
        ),
        MenuItemButton(
          onPressed: () => handleJsonBackupImport(context),
          leadingIcon: const Icon(LucideIcons.cloudDownload),
          child: Text(l10n.importBackupButtonText),
        ),
      ],
      builder: (BuildContext context, MenuController menu, _) {
        return IconButton(
          padding: const EdgeInsets.fromLTRB(8, 8, 2, 8),
          onPressed: () => menu.isOpen ? menu.close() : menu.open(),
          tooltip: l10n.backupSectionTitle,
          icon: const Row(
            children: [
              Icon(LucideIcons.database, size: 20),
              Icon(Icons.arrow_drop_down_rounded),
            ],
          ),
        );
      },
    );
  }
}
