part of 'tree_view.dart';

class TreeNodeWidget extends StatelessWidget {
  const TreeNodeWidget({
    super.key,
    required this.classe,
    required this.hasChildren,
  });

  final Classe classe;
  final bool hasChildren;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => navigator.showClassEditor(classId: classe.id),
        child: Row(
          children: <Widget>[
            // TODO: adjust widgets to handle empty class name and/or code
            _ClasseCodeChip(classe: classe),
            const SizedBox(width: 8),
            _ClasseTitle(classe: classe),
            if (!hasChildren) _ClasseDeleteButton(classe: classe),
            _ClasseNewChildButton(classe: classe),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _ClasseNewChildButton extends StatelessWidget {
  const _ClasseNewChildButton({required this.classe});

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      tooltip: AppLocalizations.of(context).newSubordinateClassButtonText,
      onPressed: () => navigator.showClassEditor(parentId: classe.id),
    );
  }
}

class _ClasseDeleteButton extends StatelessWidget {
  const _ClasseDeleteButton({required this.classe});

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return IconButton(
      tooltip: l10n.deleteButtonText,
      color: Theme.of(context).colorScheme.error,
      icon: const Icon(Icons.delete),
      onPressed: () async {
        final delete = await navigator.showWarningDialog(
          title: l10n.areYouSureDialogTitle,
          confirmButtonText: l10n.deleteButtonText,
        );
        if ((delete ?? false) && context.mounted) {
          final repository = context.read<ClassesRepository>();
          await repository.delete(classe);
        }
      },
    );
  }
}

class _ClasseTitle extends StatelessWidget {
  const _ClasseTitle({required this.classe});

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        classe.name,
        style: Theme.of(context).textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _ClasseCodeChip extends StatelessWidget {
  const _ClasseCodeChip({required this.classe});

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: classe.id == null
          ? null
          : context.read<ClassesRepository>().buildReferenceCode(classe.id!),
      child: Chip(
        padding: EdgeInsets.zero,
        label: Text(classe.code),
      ),
    );
  }
}
