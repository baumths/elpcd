part of '../settings.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SettingsSectionModel model;

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
                    model.title,
                    style: theme.textTheme.subtitle2,
                  ),
                ),
                if (model.infoTooltip != null)
                  Tooltip(
                    preferBelow: false,
                    verticalOffset: 15,
                    message: model.infoTooltip!,
                    child: const Icon(Icons.info_outline_rounded),
                  )
              ],
            ),
          ),
          const Divider(height: 1),
          model.body,
        ],
      ),
    );
  }
}
