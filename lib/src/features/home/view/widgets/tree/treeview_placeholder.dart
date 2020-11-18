part of 'treeview.dart';

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
