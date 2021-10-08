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

        return Column(
          children: [
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
              borderRadius: AppBorderRadius.bottom,
            ),
          ],
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
    this.borderRadius = BorderRadius.zero,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final BorderRadius borderRadius;

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
      labelStyle = theme.textTheme.subtitle1?.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      iconColor = AppColors.primaryLight;
      labelStyle = theme.textTheme.subtitle1;
    }

    return InkWell(
      onTap: () => onChanged(label),
      hoverColor: theme.hoverColor,
      borderRadius: borderRadius,
      child: Row(
        children: <Widget>[
          Radio<String>(
            value: label,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: primaryColor,
            //? +8px all around
            visualDensity: VisualDensity.adaptivePlatformDensity.copyWith(
              horizontal: 2,
              vertical: 2,
            ),
          ),
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
    );
  }
}
