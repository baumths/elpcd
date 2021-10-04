part of '../menu.dart';

class MenuContent extends StatelessWidget {
  const MenuContent({
    Key key = const Key('MenuContent'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MenuController controller = Menu.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(
        AppEdgeInsets.large,
      ).copyWith(left: 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppBorderRadius.all,
        ),
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            return AnimatedSwitcher(
              child: Menu.destinations[controller.index].content,
              duration: kAnimationDuration,
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation.drive(Tween(begin: .95, end: 1)),
                    child: child,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
