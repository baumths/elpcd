import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../animated_state.dart';
import '../box.dart';

part '_actions.dart';

class Sidebar<T extends Object> extends StatefulWidget {
  const Sidebar({
    Key key = const Key('SideBar'),
    this.actionsWidth = 48,
    this.contentWidth = 272,
    required this.topActions,
    this.bottomActions = const [],
    required this.contentBuilder,
  }) : super(key: key);

  final double actionsWidth;
  final double contentWidth;

  final List<SidebarActionItem<T>> topActions;
  final List<SidebarActionItem<T>> bottomActions;

  final SidebarContentBuilder<T> contentBuilder;

  @override
  _SidebarState<T> createState() => _SidebarState<T>();
}

class _SidebarState<T extends Object> extends AnimatedState<Sidebar<T>> {
  T? _selectedAction;
  T? get selectedAction => _selectedAction;

  bool get isOpen => selectedAction != null;

  void toggleAction(T action) {
    if (action == selectedAction) {
      // User pressed on open action. Close it.

      setState(() {
        _selectedAction = null;
      });

      animateReverse();
    } else {
      setState(() {
        _selectedAction = action;
      });

      animateForward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return DecoratedBox(
      // Fills background of actions and content inner rounded corners
      decoration: BoxDecoration(
        color: colorScheme.primaryVariant.withOpacity(.85),
        borderRadius: AppBorderRadius.all,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //* Content
          Flexible(
            key: const Key('SidebarContent'),
            child: AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  width: lerpDouble(0, widget.contentWidth, animation.value),
                  child: animation.value > .99 ? child : null,
                );
              },
              child: widget.contentBuilder(context, selectedAction),
            ),
          ),
          //* Actions
          AnimatedBox(
            key: const Key('SidebarActions'),
            width: widget.actionsWidth,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: isOpen //
                  ? AppBorderRadius.right
                  : AppBorderRadius.all,
            ),
            child: Column(
              children: <Widget>[
                ...widget.topActions.map(_buildAction),
                const Spacer(),
                ...widget.bottomActions.map(_buildAction),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction(SidebarActionItem<T> item) {
    return _SidebarAction(
      isSelected: item.action == selectedAction,
      icon: item.icon,
      tooltip: item.tooltip,
      onPressed: () => toggleAction(item.action),
    );
  }

  @override
  Duration get duration => const Duration(milliseconds: 300);
}
