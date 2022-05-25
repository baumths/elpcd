import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import 'widgets.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

// TODO: Refactor this mess

class _SearchBarState extends State<SearchBar> {
  late final FocusNode focusNode;
  OverlayEntry? overlayEntry;
  OverlayEntry? overlayEntryBarrier;

  bool _createOverlay() {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return false;

    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    overlayEntryBarrier = OverlayEntry(
      builder: (_) {
        return Positioned.fill(
          child: ColoredBox(
            color: AppColors.primary15,
            child: GestureDetector(onTap: () {
              focusNode.unfocus();
            }),
          ),
        );
      },
    );

    overlayEntry = OverlayEntry(
      builder: (_) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height + AppInsets.small,
          width: size.width,
          child: Material(
            elevation: 12,
            borderRadius: AppBorderRadius.all,
            color: AppColors.white,
            borderOnForeground: false,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, int index) {
                ShapeBorder? shapeBorder;
                if (index == 0) {
                  shapeBorder = const RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.top,
                  );
                } else if (index == 9) {
                  shapeBorder = const RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.bottom,
                  );
                }
                return ListTile(
                  title: Text('$index'),
                  onTap: () {},
                  shape: shapeBorder,
                );
              },
              itemCount: 10,
            ),
          ),
        );
      },
    );
    return true;
  }

  void _handleFocusChange() {
    if (focusNode.hasFocus) {
      final canShowOverlay = _createOverlay();
      if (canShowOverlay) {
        Overlay.of(context)?.insertAll([overlayEntryBarrier!, overlayEntry!]);
      }
    } else {
      overlayEntry?.remove();
      overlayEntryBarrier?.remove();
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode()..addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    overlayEntryBarrier?.dispose();
    overlayEntryBarrier = null;
    overlayEntry?.dispose();
    overlayEntry = null;
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final iconTheme = theme.iconTheme.copyWith(color: kSearchBarOnSurfaceColor);

    return Material(
      borderRadius: AppBorderRadius.all,
      color: colorScheme.surface,
      elevation: kSearchBarElevation,
      shadowColor: Colors.white,
      child: Focus(
        focusNode: focusNode,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          borderRadius: AppBorderRadius.all,
          onTap: focusNode.requestFocus,
          child: IconTheme(
            data: iconTheme,
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppInsets.medium,
                  ),
                  child: Icon(Icons.search_rounded),
                ),
                Expanded(
                  child: SearchInput(),
                ),
                VerticalDivider(
                  color: kSearchBarOnSurfaceColor,
                  indent: 4,
                  endIndent: 4,
                  width: .5,
                  thickness: .5,
                ),
                FilterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
