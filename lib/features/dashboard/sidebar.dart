import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app_info.dart';
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
    return FocusTraversalGroup(
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: const SizedBox(
          width: 300,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: DashboardSidebarHeader(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 8, 16, 8),
                  child: DashboardTabList(),
                ),
              ),
              Card(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                child: InstitutionCodeListTile(),
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
    return const Row(
      children: [
        ElpcdLogo(),
        Spacer(),
        DataExchangeMenuButton(),
        DarkModeSwitchIconButton(),
      ],
    );
  }
}

class ElpcdLogo extends StatelessWidget {
  const ElpcdLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return MenuAnchor(
      builder: (BuildContext context, MenuController menu, Widget? child) {
        return Ink(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: theme.colorScheme.surfaceContainerHigh,
          ),
          child: IconButton(
            padding: const EdgeInsetsDirectional.only(start: 8, end: 2),
            onPressed: () => menu.isOpen ? menu.close() : menu.open(),
            icon: child!,
          ),
        );
      },
      menuChildren: [
        Link(
          uri: sourceCodeUrl,
          target: LinkTarget.blank,
          builder: (context, _) => MenuItemButton(
            onPressed: () => launchUrl(sourceCodeUrl),
            leadingIcon: Image.asset(
              'assets/github-mark.png',
              height: 24,
              color: theme.colorScheme.onSurface,
            ),
            trailingIcon: const Icon(LucideIcons.externalLink),
            child: Text(l10n.sourceCodeButtonText),
          ),
        ),
        Link(
          uri: blogUrl,
          target: LinkTarget.blank,
          builder: (context, _) => MenuItemButton(
            onPressed: () => launchUrl(blogUrl),
            leadingIcon: Image.asset(
              'assets/opds-logo.png',
              height: 24,
              color: theme.colorScheme.onSurface,
            ),
            trailingIcon: const Icon(LucideIcons.externalLink),
            child: Text(l10n.opdsBlogButtonText),
          ),
        ),
        MenuItemButton(
          onPressed: () => showAboutDialog(
            context: context,
            applicationName: l10n.appTitle,
            applicationVersion: appInfo?.version,
            applicationIcon: Image.asset(
              'assets/elpcd-icon.png',
              height: 56,
              width: 56,
            ),
          ),
          leadingIcon: const SizedBox.square(
            dimension: 24,
            child: Center(
              child: Icon(LucideIcons.info),
            ),
          ),
          child: Text(
            MaterialLocalizations.of(context).aboutListTileTitle(
              l10n.appTitle,
            ),
          ),
        ),
      ],
      child: Row(
        children: [
          Image.asset(
            'assets/elpcd-icon-fg.png',
            height: 24,
            width: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          Icon(
            Icons.arrow_drop_down_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }

  static final sourceCodeUrl = Uri.parse('https://github.com/baumths/elpcd');
  static final blogUrl = Uri.parse(
    'https://documentosarquivisticosdigitais.blogspot.com',
  );
}
