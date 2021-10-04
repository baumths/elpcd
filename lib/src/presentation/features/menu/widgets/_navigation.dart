part of '../menu.dart';

class MenuNavigation extends StatelessWidget {
  const MenuNavigation({
    Key key = const Key('MenuNavigation'),
    required this.destinations,
  }) : super(key: key);

  final List<NavigationRailDestination> destinations;

  /// Copied from flutter/painting/shadows/kElevationToShadow[12]
  ///
  /// The shadows were shifted from bottom to right.
  static const List<BoxShadow> kElevationShadows = <BoxShadow>[
    BoxShadow(
      offset: Offset(7.0, 0.0),
      blurRadius: 8.0,
      spreadRadius: -4.0,
      color: Color(0x33000000),
    ),
    BoxShadow(
      offset: Offset(12.0, 0.0),
      blurRadius: 17.0,
      spreadRadius: 2.0,
      color: Color(0x24000000),
    ),
    BoxShadow(
      offset: Offset(5.0, 0.0),
      blurRadius: 22.0,
      spreadRadius: 4.0,
      color: Color(0x1F000000),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final MenuController controller = Menu.of(context);

    return MouseRegion(
      onEnter: (_) => controller.isRailExtended = true,
      onExit: (_) => controller.isRailExtended = false,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return DecoratedBox(
            decoration: BoxDecoration(
              // Right elevation to distinct NavRail from content
              boxShadow: controller.isRailExtended ? kElevationShadows : null,
            ),
            child: NavigationRail(
              destinations: destinations,
              onDestinationSelected: (int newIndex) {
                controller.index = newIndex;
              },
              extended: controller.isRailExtended,
              selectedIndex: controller.index,
              minWidth: kNavRailMinWidth,
              minExtendedWidth: 200,
            ),
          );
        },
      ),
    );
  }
}
