import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

import '../../../localization.dart';
import '../../backup/backup_section.dart';
import '../../crosswalk/csv_export_list_tile.dart';
import '../../settings/codearq.dart';
import '../../settings/dark_mode.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const <Widget>[
          Header(),
          Divider(),
          CodearqListTile(),
          DarkModeSwitchListTile(),
          Divider(),
          CsvExportListTile(),
          Divider(),
          BackupSection(),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  static final sourceCodeUrl = Uri.parse('https://github.com/baumths/elpcd');
  static final blogUrl = Uri.parse('https://documentosdigitais.blogspot.com');

  static Future<void> launch(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final colorFilter = ColorFilter.mode(
      theme.colorScheme.onSurface,
      BlendMode.srcIn,
    );
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.appTitle,
              style: theme.textTheme.headlineLarge,
            ),
          ),
          IconButton(
            tooltip: l10n.sourceCodeButtonTooltip,
            onPressed: () => launch(sourceCodeUrl),
            icon: VectorGraphic(
              loader: const AssetBytesLoader('assets/github-mark.svg'),
              height: 24,
              colorFilter: colorFilter,
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: () => launch(blogUrl),
            tooltip: l10n.opdsBlogButtonTooltip,
            icon: VectorGraphic(
              loader: const AssetBytesLoader('assets/opds-icon.svg'),
              height: 24,
              colorFilter: colorFilter,
            ),
          ),
        ],
      ),
    );
  }
}
