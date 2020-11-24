part of 'treeview.dart';

class TreeNodeWidget extends StatelessWidget {
  const TreeNodeWidget({
    @required this.classe,
    Key key,
  })  : assert(classe != null),
        super(key: key);

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
  const _ClasseNewChildButton({
    Key key,
    @required this.classe,
  }) : super(key: key);

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
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
  const _ClasseDeleteButton({
    Key key,
    @required this.classe,
  }) : super(key: key);

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      tooltip: 'Apagar',
      color: Colors.redAccent.shade700,
      icon: const Icon(Icons.delete),
      onPressed: () async {
        // TODO: move to HomeBloc
        final delete = await showDialog<bool>(
          context: context,
          builder: (ctx) => AppDialogs.warning(
            context: ctx,
            title: 'Tem certeza?',
            btnText: 'Apagar',
          ),
        );
        if (delete ?? false) {
          final repository = RepositoryProvider.of<HiveRepository>(context);
          await repository.delete(classe);
          // TODO: show snackbar
        }
      },
    );
  }
}

class _ClasseTitle extends StatelessWidget {
  const _ClasseTitle({
    Key key,
    @required this.classe,
  }) : super(key: key);

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        classe.name,
        style: Theme.of(context).textTheme.subtitle1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _ClasseCodeChip extends StatelessWidget {
  const _ClasseCodeChip({
    @required this.classe,
    Key key,
  }) : super(key: key);

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<HiveRepository>(context);
    return ValueListenableBuilder<Box<dynamic>>(
      valueListenable: repository.listenToSettings(),
      builder: (_, box, child) {
        return Tooltip(
          message: classe.referenceCode(repository),
          child: child,
        );
      },
      child: Chip(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        label: Text(classe.code),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withOpacity(0.15)
            : Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
