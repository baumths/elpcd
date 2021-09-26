part of 'sidebar.dart';

typedef SidebarContentBuilder = Widget Function(
  BuildContext context,
  SidebarAction action,
);

enum SidebarAction {
  /// Closed content
  none,

  /// Browse Classes
  search,

  /// Export/Import app data
  exim,

  /// App settings
  settings,
}

class SidebarActionItem {
  const SidebarActionItem({
    required this.action,
    required this.icon,
    this.tooltip,
  });

  final SidebarAction action;
  final IconData icon;
  final String? tooltip;
}

class _SidebarAction extends StatelessWidget {
  const _SidebarAction({
    Key? key,
    required this.item,
    this.isSelected = false,
    required this.contentPosition,
    required this.onPressed,
  }) : super(key: key);

  final SidebarActionItem item;

  final bool isSelected;

  final ContentPosition contentPosition;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final Color selectedColor = colorScheme.onPrimary;
    final Color unselectedColor = selectedColor.withOpacity(.6);

    Color color = unselectedColor;
    Decoration? borderDecoration;

    if (isSelected) {
      color = selectedColor;

      final BorderSide borderSide = BorderSide(color: color, width: 2);

      borderDecoration = BoxDecoration(
        border: contentPosition == ContentPosition.left
            ? Border(left: borderSide)
            : Border(right: borderSide),
      );
    }

    return Box(
      width: 48,
      height: 48,
      decoration: borderDecoration,
      child: IconButton(
        color: color,
        icon: Icon(item.icon),
        tooltip: item.tooltip,
        padding: EdgeInsets.zero,
        splashRadius: kmSplashRadius,
        onPressed: onPressed,
      ),
    );
  }
}
