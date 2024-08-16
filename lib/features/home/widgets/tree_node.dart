part of 'tree_view.dart';

class TreeNodeWidget extends StatelessWidget {
  const TreeNodeWidget({
    super.key,
    required this.clazz,
    required this.hasChildren,
  });

  final Classe clazz;
  final bool hasChildren;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: () => navigator.showClassEditor(classId: clazz.id),
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(6)),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 8),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    if (clazz.code.isNotEmpty) ...[
                      TextSpan(
                        text: clazz.code,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' - '),
                    ],
                    if (clazz.name.isEmpty)
                      TextSpan(
                        text: AppLocalizations.of(context).unnamedClass,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      )
                    else
                      TextSpan(text: clazz.name),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (!hasChildren)
              IconButton(
                tooltip: l10n.deleteButtonText,
                color: theme.colorScheme.error,
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final delete = await navigator.showWarningDialog(
                    title: l10n.areYouSureDialogTitle,
                    confirmButtonText: l10n.deleteButtonText,
                  );
                  if ((delete ?? false) && context.mounted) {
                    final repository = context.read<ClassesRepository>();
                    await repository.delete(clazz);
                  }
                },
              ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: l10n.newSubordinateClassButtonText,
              onPressed: () => navigator.showClassEditor(parentId: clazz.id),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
