import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // TODO: get from user preferences ??? options: [CÓDIGO, NOME]
    const String selectedFilter = 'CÓDIGO';

    return Tooltip(
      message: 'FILTRO',
      child: SizedBox(
        height: kSearchBarHeight,
        child: TextButton.icon(
          style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: AppBorderRadius.right,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppInsets.medium,
            ),
          ),
          icon: const Icon(
            Icons.filter_list_rounded,
            color: kSearchBarOnSurfaceColor,
          ),
          label: Text(
            selectedFilter,
            style: theme.textTheme.button?.copyWith(
              color: kSearchBarOnSurfaceColor,
            ),
          ),
          onPressed: () {
            // TODO: Setup FilterButton action (open PopupMenu)
          },
        ),
      ),
    );
  }
}
