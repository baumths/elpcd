import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../animated_state.dart';
import '../box.dart';

part '_actions.dart';

enum ContentPosition { left, right }

class Sidebar extends StatefulWidget {
  const Sidebar({
    Key key = const Key('SideBar'),
    this.actionsWidth = 48,
    this.contentWidth = 272,
    required this.topActions,
    this.bottomActions = const <SidebarActionItem>[],
    this.contentPosition = ContentPosition.left,
    required this.contentBuilder,
  }) : super(key: key);

  final double actionsWidth;
  final double contentWidth;

  final List<SidebarActionItem> topActions;
  final List<SidebarActionItem> bottomActions;

  /// The position in which the content will be animated to.
  final ContentPosition contentPosition;
  final SidebarContentBuilder contentBuilder;

  double get totalWidth => actionsWidth + contentWidth;

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends AnimatedState<Sidebar> {
  SidebarAction _selectedAction = SidebarAction.none;
  SidebarAction get selectedAction => _selectedAction;

  bool get isOpen => selectedAction != SidebarAction.none;

  void toggleAction(SidebarAction action) {
    if (action == _selectedAction) {
      // User pressed on open action. Close it.

      setState(() {
        _selectedAction = SidebarAction.none;
      });

      animateReverse();
    } else {
      setState(() {
        _selectedAction = action;
      });

      animateForward();
    }
  }

  late BorderRadiusGeometry _actionsBorderRadius;

  void _setupActionsBorderRadius() {
    if (widget.contentPosition == ContentPosition.left) {
      _actionsBorderRadius = AppBorderRadius.right;
    } else {
      _actionsBorderRadius = AppBorderRadius.left;
    }
  }

  @override
  void initState() {
    super.initState();
    _setupActionsBorderRadius();
  }

  @override
  void didUpdateWidget(covariant Sidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.contentPosition != widget.contentPosition) {
      _setupActionsBorderRadius();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    late final Widget content = Flexible(
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
    );

    late final Widget actions = AnimatedBox(
      key: const Key('SidebarActions'),
      width: widget.actionsWidth,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: isOpen ? _actionsBorderRadius : AppBorderRadius.all,
      ),
      child: Column(
        children: <Widget>[
          ...widget.topActions.map(_buildAction),
          const Spacer(),
          ...widget.bottomActions.map(_buildAction),
        ],
      ),
    );

    return DecoratedBox(
      // Fills background of actions and content inner rounded corners
      decoration: BoxDecoration(
        color: colorScheme.primaryVariant.withOpacity(.85),
        borderRadius: AppBorderRadius.all,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: widget.contentPosition == ContentPosition.left
            ? <Widget>[content, actions]
            : <Widget>[actions, content],
      ),
    );
  }

  Widget _buildAction(SidebarActionItem item) {
    return _SidebarAction(
      isSelected: item.action == selectedAction,
      item: item,
      contentPosition: widget.contentPosition,
      onPressed: () => toggleAction(item.action),
    );
  }

  @override
  Curve get curve => Curves.fastOutSlowIn;

  @override
  Duration get duration => const Duration(milliseconds: 500);
}
