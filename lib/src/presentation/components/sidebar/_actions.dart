part of 'sidebar.dart';

typedef SidebarContentBuilder<T> = Widget Function(
  BuildContext context,
  T? action,
);

class SidebarActionItem<T extends Object> {
  const SidebarActionItem({
    required this.action,
    required this.icon,
    this.tooltip,
  });

  final T action;
  final IconData icon;
  final String? tooltip;
}

class _SidebarAction extends StatelessWidget {
  const _SidebarAction({
    Key? key,
    required this.icon,
    this.isSelected = false,
    this.tooltip,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String? tooltip;
  final bool isSelected;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    Decoration? borderDecoration;

    Color color = colorScheme.onPrimary.withOpacity(.6);

    if (isSelected) {
      color = colorScheme.onPrimary;

      borderDecoration = BoxDecoration(
        border: Border(
          left: BorderSide(
            color: color,
            width: 2,
          ),
        ),
      );
    }

    return Box(
      width: 48,
      height: 48,
      decoration: borderDecoration,
      child: IconButton(
        color: color,
        icon: Icon(icon),
        tooltip: tooltip,
        padding: EdgeInsets.zero,
        splashRadius: kmSplashRadius,
        onPressed: onPressed,
      ),
    );
  }
}
