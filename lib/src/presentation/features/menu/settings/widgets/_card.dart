part of 'widgets.dart';

class SettingsCardContent {
  SettingsCardContent({
    required this.title,
    required this.builder,
    this.infoTooltip,
  });

  final String title;
  final WidgetBuilder builder;
  final String? infoTooltip;
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    Key? key,
    required this.content,
  }) : super(key: key);

  final SettingsCardContent content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 8,
      clipBehavior: Clip.hardEdge,
      color: theme.colorScheme.surface,
      borderRadius: AppBorderRadius.all,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    content.title,
                    style: theme.textTheme.subtitle2,
                  ),
                ),
                if (content.infoTooltip != null)
                  Tooltip(
                    preferBelow: false,
                    verticalOffset: 15,
                    message: content.infoTooltip!,
                    child: const Icon(Icons.info_outline_rounded),
                  )
              ],
            ),
          ),
          const Divider(height: 1),
          content.builder(context),
        ],
      ),
    );
  }
}
