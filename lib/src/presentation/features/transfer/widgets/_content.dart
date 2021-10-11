part of '../transfer.dart';

class SectionContent extends StatelessWidget {
  const SectionContent({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color iconColor = theme.colorScheme.primary;
    final TextStyle defaultTextStyle = theme.textTheme.subtitle1!.copyWith(
      color: theme.colorScheme.primary,
    );

    return DefaultTextStyle(
      style: defaultTextStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(icon, size: 32, color: iconColor),
            ],
          ),
          const SizedBox(height: AppInsets.medium),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
