import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      style: theme.textTheme.headline6,
      decoration: const InputDecoration(
        border: InputBorder.none,
        enabled: false,
        contentPadding: EdgeInsets.zero,
        hintText: 'Pesquisar Classes',
        hintStyle: TextStyle(color: kSearchBarOnSurfaceColor),
      ),
    );
  }
}
