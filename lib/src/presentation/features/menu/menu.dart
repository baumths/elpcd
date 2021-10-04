import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../main/main_view.dart';
import '../settings/settings.dart';

part '_controller.dart';
part '_utils.dart';
part 'widgets/_content.dart';
part 'widgets/_navigation.dart';

class Menu extends StatefulWidget {
  const Menu({
    Key key = const Key('MenuView'),
  }) : super(key: key);

  static const List<MenuDestination> destinations = [
    MenuDestination(
      label: Text('VISUALIZAR'),
      icon: Icon(Icons.account_tree_rounded),
      content: Browse(),
    ),
    MenuDestination(
      label: Text('TRANSFERIR'),
      icon: Icon(Icons.leak_add_rounded),
      content: Center(child: Text('TRANSFER VIEW')),
    ),
    MenuDestination(
      label: Text('CONFIGURAR'),
      icon: Icon(Icons.settings_rounded),
      content: Settings(),
    ),
  ];

  static MenuController of(BuildContext context) {
    final instance = context.dependOnInheritedWidgetOfExactType<MenuScope>();
    assert(instance != null, 'No Menu found in given BuildContext');
    return instance!.controller;
  }

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late final MenuController controller;

  @override
  void initState() {
    super.initState();
    controller = MenuController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // TODO: Use ResponsiveBuilder for smaller screens here
    // TODO: Move nav rail to its own widget

    return MenuScope(
      controller: controller,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: AppBorderRadius.right,
        ),
        child: Stack(
          children: const [
            Positioned.fill(
              left: kNavRailMinWidth,
              child: MenuContent(),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: MenuNavigation(
                destinations: Menu.destinations,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
