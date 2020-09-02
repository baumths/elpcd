part of '../home_view.dart';

class TreeViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<PCDModel>>(
      valueListenable: HiveDatabase.pcdBox.listenable(),
      builder: (_, box, __) {
        if (box.isEmpty) return _TreeViewPlaceholder();

        return FutureBuilder(
          future: HiveDatabase.getChildren(),
          builder: (_, AsyncSnapshot<List<PCDModel>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                if (!snapshot.hasData) continue loadingLabel;

                return TreeView(
                  data: snapshot.data,
                  onTap: (pcd) {
                    var homeManager = context.read<HomeManager>();
                    return homeManager.openDescription(
                      context,
                      DescriptionManager.viewClass(pcd: pcd),
                    );
                  },
                );
              loadingLabel:
              case ConnectionState.none:
              case ConnectionState.waiting:
              default:
                return _buildWaitingView();
            }
          },
        );
      },
    );
  }

  Widget _buildWaitingView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
