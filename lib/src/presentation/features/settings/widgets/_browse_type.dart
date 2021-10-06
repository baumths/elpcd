part of '../settings.dart';

class BrowseTypeSection extends StatelessWidget {
  const BrowseTypeSection({
    Key key = const Key('BrowseTypeSection'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: get from user preferences
    String selectedType = 'Hierárquica';

    // TODO: Use a SettingsController to manage state
    return StatefulBuilder(
      builder: (_, StateSetter setState) {
        void select(String? value) {
          if (value == null || value == selectedType) return;
          setState(() => selectedType = value);
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: AppEdgeInsets.xSmall),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _RadioTile(
                groupValue: selectedType,
                label: 'Hierárquica',
                icon: Icons.account_tree_rounded,
                onChanged: select,
              ),
              _RadioTile(
                groupValue: selectedType,
                label: 'Multinível',
                icon: Icons.layers_rounded,
                onChanged: select,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RadioTile extends StatelessWidget {
  const _RadioTile({
    Key? key,
    required this.label,
    required this.icon,
    this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final IconData icon;

  final String? groupValue;

  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Color primaryColor = colorScheme.primary;

    late Color iconColor;
    late TextStyle? labelStyle;

    if (label == groupValue) {
      iconColor = primaryColor;
      labelStyle = theme.textTheme.subtitle1;
    } else {
      iconColor = AppColors.primaryLight;
      labelStyle = theme.textTheme.subtitle1;
    }

    return Material(
      color: Colors.transparent,
      borderRadius: AppBorderRadius.all,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => onChanged(label),
        hoverColor: theme.hoverColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppEdgeInsets.xSmall * 1.5,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: AppEdgeInsets.small,
                ),
                child: Radio<String>(
                  value: label,
                  groupValue: groupValue,
                  activeColor: primaryColor,
                  onChanged: onChanged,
                ),
              ),
              const SizedBox(width: AppEdgeInsets.small),
              Expanded(
                child: Text(label, style: labelStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppEdgeInsets.medium,
                ),
                child: Icon(icon, color: iconColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
