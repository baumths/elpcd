part of '../home_view.dart';

class TreeViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<PCDModel>>(
      valueListenable: HiveDatabase.pcdBox.listenable(),
      builder: (_, box, __) {
        if (box.isEmpty) return _TreeViewPlaceholder();
        final rootNodes = box.values.where((pcd) => pcd.parentId == -1);

        return FutureBuilder(
          future: _buildNodes(rootNodes),
          initialData: const <TreeNode>[],
          builder: (_, AsyncSnapshot<List<TreeNode>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                if (!snapshot.hasData) continue loadingLabel;
                return TreeView(
                  indent: 16,
                  treeController: context.read<TreeController>(),
                  nodes: snapshot.data,
                );
              loadingLabel:
              case ConnectionState.none:
              case ConnectionState.waiting:
              default:
                return _WaitingView();
            }
          },
        );
      },
    );
  }

  Future<List<TreeNode>> _buildNodes(Iterable<PCDModel> holdings) async {
    return <TreeNode>[
      for (final pcd in holdings)
        TreeNode(
          key: ValueKey(pcd.legacyId),
          children: pcd.hasChildren
              ? await _buildNodes(await pcd.children)
              : const [],
          content: _NodeWidget(pcd: pcd),
        )
    ];
  }
}

class _NodeWidget extends StatelessWidget {
  _NodeWidget({this.pcd});

  final PCDModel pcd;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          tooltip: 'Nova Classe Subordinada',
          icon: const Icon(Icons.add),
          onPressed: () {
            context.display(
              DescriptionView(
                DescriptionManager.newClass(parent: this.pcd),
              ),
            );
          },
        ),
        IconButton(
          splashRadius: 20,
          tooltip: 'Visualizar Classe',
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            var homeManager = context.read<HomeManager>();
            return homeManager.openDescription(
              context,
              DescriptionManager.viewClass(pcd: this.pcd),
            );
          },
        ),
      ],
    ).expanded();
  }
}

class _WaitingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          const Text('Aguarde enquanto seus dados são carregados'),
          const SizedBox(height: 8),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class _TreeViewPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      // TODO: add button to start by importing data
      child: Text(
        'Crie uma Classe para começar',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
