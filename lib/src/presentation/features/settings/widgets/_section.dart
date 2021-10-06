part of '../settings.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SettingsSectionModel model;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: AppBorderRadius.all,
        border: Border.fromBorderSide(
          BorderSide(
            color: AppColors.primaryLight,
            width: 1.5,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Header(model: model),
          const Divider(),
          model.body,
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.model,
  }) : super(key: key);

  final SettingsSectionModel model;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppEdgeInsets.medium,
      ),
      child: SizedBox(
        height: 40,
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
              ),
          ],
        ),
      ),
    );
  }
}
