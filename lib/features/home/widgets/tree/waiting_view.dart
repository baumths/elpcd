part of 'treeview.dart';

class _WaitingView extends StatelessWidget {
  const _WaitingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Aguarde enquanto seus dados são carregados',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
