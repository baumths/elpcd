part of 'treeview.dart';

class TreeNodeWidget extends StatelessWidget {
  const TreeNodeWidget({@required this.pcd}) : assert(pcd != null);

  final PCDModel pcd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeController>().navigationRequested(
              context,
              ComposeView.routeName,
              args: pcd,
            );
      },
      child: Row(
        children: <Widget>[
          Tooltip(
            message: pcd.identifier,
            child: Chip(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              label: Text(pcd.codigo),
              backgroundColor: context.isDarkMode()
                  ? Colors.white.withOpacity(0.15)
                  : Colors.grey.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            pcd.nome,
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
              context.display(
                DescriptionView(
                  DescriptionController.newClass(parent: pcd),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    ).expanded();
  }
}
