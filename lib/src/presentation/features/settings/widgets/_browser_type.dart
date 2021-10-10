part of '../settings.dart';

class BrowserTypeSection extends StatelessWidget {
  const BrowserTypeSection({
    Key key = const Key('BrowserTypeSection'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _RadioTile(
          label: 'Hierárquica',
          icon: Icons.account_tree_rounded,
        ),
        _RadioTile(
          label: 'Multinível',
          icon: Icons.layers_rounded,
          borderRadius: AppBorderRadius.bottom,
        ),
      ],
    );
  }
}

class _RadioTile extends StatelessWidget {
  const _RadioTile({
    Key? key,
    required this.label,
    required this.icon,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final controller = Settings.of(context).browserTypeController;

    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Color primaryColor = colorScheme.primary;

    return InkWell(
      onTap: () => controller.select(label),
      hoverColor: theme.hoverColor,
      borderRadius: borderRadius,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          late Color iconColor;
          late TextStyle? labelStyle;

          final bool isSelected = label == controller.selectedType;

          if (isSelected) {
            iconColor = primaryColor;
            labelStyle = theme.textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.bold,
            );
          } else {
            iconColor = AppColors.primaryLight;
            labelStyle = theme.textTheme.subtitle1;
          }

          return Row(
            children: <Widget>[
              Radio<String>(
                value: label,
                groupValue: controller.selectedType,
                onChanged: (_) => controller.select(label),
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
                padding: const EdgeInsets.all(AppInsets.medium),
                child: Icon(icon, color: iconColor),
              ),
            ],
          );
        },
      ),
    );
  }
}
