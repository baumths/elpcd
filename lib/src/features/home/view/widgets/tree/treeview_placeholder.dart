part of 'treeview.dart';

class _TreeViewPlaceholder extends StatelessWidget {
  const _TreeViewPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Crie uma Classe para começar',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
