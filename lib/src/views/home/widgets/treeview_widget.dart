part of '../home_view.dart';

class TreeviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<PCDModel>>(
      valueListenable: HiveDatabase.pcdBox.listenable(),
      builder: (_, box, __) {
        if (box.isEmpty) return _TreeViewPlaceholder();
        return FutureBuilder(
          future: _buildNodes(HiveDatabase.getClasses()),
          builder: (_, AsyncSnapshot<List<TreeNode>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasData) continue loadingLabel;
                return Consumer<TreeManager>(
                  builder: (_, manager, __) {
                    return Scrollbar(
                      radius: const Radius.circular(24),
                      thickness: 8,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 72),
                        child: TreeView(
                          indent: context.isSmallDisplay ? 8 : 24,
                          treeController: manager.treeController,
                          nodes: snapshot.data,
                        ),
                      ),
                    );
                  },
                );
              loadingLabel:
              case ConnectionState.none:
              case ConnectionState.active:
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
              ? await _buildNodes(pcd.children)
              : const <TreeNode>[],
          content: TreeNodeWidget(pcd: pcd),
        )
    ];
  }
}

class _WaitingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          const Text(
            'Aguarde enquanto seus dados são carregados',
            textAlign: TextAlign.center,
          ),
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
