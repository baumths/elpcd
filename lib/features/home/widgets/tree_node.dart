part of 'tree_view.dart';

class TreeNodeWidget extends StatelessWidget {
  const TreeNodeWidget({super.key, required this.classe});

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(ComposeView.routeName, arguments: classe),
        child: Row(
          children: <Widget>[
            _ClasseCodeChip(classe: classe),
            const SizedBox(width: 8),
            _ClasseTitle(classe: classe),
            if (!classe.hasChildren) _ClasseDeleteButton(classe: classe),
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
      tooltip: 'Nova Classe Subordinada',
      onPressed: () {
        Navigator.of(context).pushNamed(
          ComposeView.routeName,
          arguments: Classe.fromParent(classe.id),
        );
      },
    );
  }
}

class _ClasseDeleteButton extends StatelessWidget {
  const _ClasseDeleteButton({required this.classe});

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Apagar',
      color: Theme.of(context).colorScheme.error,
      icon: const Icon(Icons.delete),
      onPressed: () async {
        final delete = await showDialog<bool>(
          context: context,
          builder: (ctx) => AppDialogs.warning(
            context: ctx,
            title: 'Tem certeza?',
            btnText: 'Apagar',
          ),
        );
        if ((delete ?? false) && context.mounted) {
          final repository = RepositoryProvider.of<HiveRepository>(context);
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
    final repository = RepositoryProvider.of<HiveRepository>(context);
    return ValueListenableBuilder(
      valueListenable: repository.listenToSettings(),
      builder: (_, __, child) {
        return Tooltip(
          message: classe.referenceCode(repository),
          child: child,
        );
      },
      child: Chip(
        padding: EdgeInsets.zero,
        label: Text(classe.code),
      ),
    );
  }
}
