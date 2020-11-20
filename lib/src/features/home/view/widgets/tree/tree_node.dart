part of 'treeview.dart';

class TreeNodeWidget extends StatelessWidget {
  const TreeNodeWidget({@required this.classe}) : assert(classe != null);

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // TODO: Navigate to browse view
          Navigator.of(context).pushNamed(
            ComposeView.routeName,
            arguments: classe,
          );
        },
        child: Row(
          children: <Widget>[
            Tooltip(
              message: classe.referenceCode,
              child: Chip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                label: Text(classe.code),
                backgroundColor: context.isDarkMode()
                    ? Colors.white.withOpacity(0.15)
                    : Colors.grey.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              classe.name,
              style: context.theme.textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,
            ).expanded(),
            IconButton(
              splashRadius: 20,
              tooltip: 'Apagar',
              color: Colors.redAccent.shade700,
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  child: AppDialogs.warning(
                    context: context,
                    btnText: 'APAGAR',
                    title: 'Deseja realmente apagar?',
                  ),
                );
              },
            ),
            IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.add),
              tooltip: 'Nova Classe Subordinada',
              onPressed: () {
                Navigator.of(context).pushNamed(
                  ElPCDRouter.compose,
                  arguments: Classe.fromParent(classe.id),
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
