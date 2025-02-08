import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../app/navigator.dart' as navigator;
import '../../localization.dart';
import '../../repositories/classes_repository.dart';
import '../../shared/class_title.dart';

class SearchClassesButton extends StatelessWidget {
  const SearchClassesButton({super.key, this.style});

  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      suggestionsBuilder: buildSuggestions,
      builder: (BuildContext context, SearchController controller) {
        return IconButton(
          icon: const Icon(LucideIcons.search),
          onPressed: controller.openView,
          tooltip: AppLocalizations.of(context).searchClassesButtonText,
          style: style,
        );
      },
      viewLeading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(LucideIcons.arrowLeft),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      ),
      viewConstraints: const BoxConstraints(minWidth: 600, minHeight: 400),
      viewShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    );
  }

  Iterable<Widget> buildSuggestions(
    BuildContext context,
    SearchController controller,
  ) {
    var classes = context.read<ClassesRepository>().getAllClasses();

    if (controller.text.isNotEmpty) {
      classes = classes.where((clazz) {
        return (clazz.code + clazz.name)
            .toLowerCase()
            .contains(controller.text.toLowerCase());
      });
    }

    return classes.map((clazz) {
      return ListTile(
        title: ClassTitle(clazz: clazz),
        trailing: const Icon(LucideIcons.arrowRight),
        onTap: () {
          controller.closeView(null);
          navigator.showClassEditor(classId: clazz.id);
        },
      );
    });
  }
}
