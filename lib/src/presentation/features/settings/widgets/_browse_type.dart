part of '../settings.dart';

class BrowseTypeTile extends StatelessWidget {
  const BrowseTypeTile({
    Key key = const Key('BrowserTypeTile'),
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
    final Color primaryColor = theme.colorScheme.primary;

    final Color iconColor = label == groupValue ? primaryColor : Colors.grey;

    return InkWell(
      onTap: () => onChanged(label),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Radio<String>(
                value: label,
                groupValue: groupValue,
                activeColor: primaryColor,
                onChanged: onChanged,
              ),
            ),
            Expanded(child: Text(label)),
            Icon(icon, color: iconColor),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
