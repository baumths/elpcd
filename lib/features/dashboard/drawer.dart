import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

import '../../../localization.dart';
import '../backup/backup_section.dart';
import '../crosswalk/csv_export_list_tile.dart';
import '../settings/dark_mode.dart';
import '../settings/institution_code.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const <Widget>[
          Header(),
          Divider(),
          InstitutionCodeListTile(),
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

  static const sourceCodeUrl = 'https://github.com/baumths/elpcd';
  static const blogUrl = 'https://documentosarquivisticosdigitais.blogspot.com';

  static Future<void> launch(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
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
