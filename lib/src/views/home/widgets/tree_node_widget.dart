part of '../home_view.dart';

class TreeNodeWidget extends StatelessWidget {
  TreeNodeWidget({@required this.pcd}) : assert(pcd != null);

  final PCDModel pcd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var homeManager = context.read<HomeManager>();
        homeManager.openDescription(
          context,
          DescriptionManager.viewClass(pcd: this.pcd),
        );
      },
      child: Row(
        children: <Widget>[
          Tooltip(
            message: this.pcd.identifier,
            child: Chip(
              label: Text(this.pcd.codigo),
              backgroundColor: context.isDarkMode()
                  ? Colors.white.withOpacity(0.15)
                  : Colors.grey.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            this.pcd.nome,
            style: context.theme().textTheme.subtitle1,
            overflow: TextOverflow.ellipsis,
          ).expanded(),
          IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.add),
            tooltip: 'Nova Classe Subordinada',
            hoverColor: context.theme().accentColor,
            onPressed: () {
              context.display(
                DescriptionView(
                  DescriptionManager.newClass(parent: this.pcd),
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
