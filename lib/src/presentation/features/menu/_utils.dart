part of 'menu.dart';

const double kNavRailMinWidth = 64.0;

class MenuDestination extends NavigationRailDestination {
  const MenuDestination({
    required Widget label,
    required Widget icon,
    required this.content,
  }) : super(label: label, icon: icon);

  final Widget content;
}

class MenuScope extends InheritedWidget {
  const MenuScope({
    Key? key,
    required this.controller,
    required Widget child,
  }) : super(key: key, child: child);

  final MenuController controller;

  @override
  bool updateShouldNotify(MenuScope oldWidget) => false;
}
