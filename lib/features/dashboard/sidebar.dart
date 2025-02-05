import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../localization.dart';
import '../../shared/data_exchange_menu_button.dart';
import '../settings/dark_mode.dart';
import '../settings/institution_code.dart';
import 'controller.dart';
import 'tabs.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          context.read<DashboardController>().sidebarVisibilityNotifier,
      builder: (BuildContext context, bool isSidebarVisible, _) {
        if (isSidebarVisible) {
          return const Row(
            children: [
              DashboardSidebarContent(),
              VerticalDivider(width: 1),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class DashboardSidebarContent extends StatelessWidget {
  const DashboardSidebarContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FocusTraversalGroup(
      child: Material(
        color: theme.colorScheme.surfaceContainer,
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                child: DashboardSidebarHeader(),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 8, 16, 8),
                  child: DashboardTabList(),
                ),
              ),
              Card(
                elevation: 0,
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  side: BorderSide(
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
                child: const InstitutionCodeListTile(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardSidebarHeader extends StatelessWidget {
  const DashboardSidebarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final colorFilter = ColorFilter.mode(
      theme.colorScheme.onSurface,
      BlendMode.srcIn,
    );
    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.appTitle,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        const DataExchangeMenuButton(),
        const DarkModeSwitchIconButton(),
        MenuAnchor(
          builder: (BuildContext context, MenuController menu, _) {
            return IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => menu.isOpen ? menu.close() : menu.open(),
            );
          },
          menuChildren: [
            Link(
              uri: sourceCodeUrl,
              target: LinkTarget.blank,
              builder: (context, _) => MenuItemButton(
                onPressed: () => launchUrl(sourceCodeUrl),
                leadingIcon: VectorGraphic(
                  loader: const AssetBytesLoader('assets/github-mark.svg'),
                  height: 20,
                  colorFilter: colorFilter,
                ),
                trailingIcon: const Icon(Icons.launch),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(l10n.sourceCodeButtonText),
                ),
              ),
            ),
            Link(
              uri: blogUrl,
              target: LinkTarget.blank,
              builder: (context, _) => MenuItemButton(
                onPressed: () => launchUrl(blogUrl),
                leadingIcon: VectorGraphic(
                  loader: const AssetBytesLoader('assets/opds-icon.svg'),
                  height: 20,
                  colorFilter: colorFilter,
                ),
                trailingIcon: const Icon(Icons.launch),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(l10n.opdsBlogButtonText),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  static final sourceCodeUrl = Uri.parse('https://github.com/baumths/elpcd');
  static final blogUrl = Uri.parse(
    'https://documentosarquivisticosdigitais.blogspot.com',
  );
}
