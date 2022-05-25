import "package:flutter/material.dart";

import '../../theme/theme.dart';
import 'widgets/widgets.dart';

class Search extends StatelessWidget {
  const Search({
    Key key = const Key('Search'),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TopBar();
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kSearchBarHeight,
      child: Row(
        children: const [
          Expanded(
            child: SearchBar(),
          ),
          SizedBox(width: AppInsets.medium),
          CreateClassButton(),
        ],
      ),
    );
  }
}
