part of 'treeview.dart';

class _WaitingView extends StatelessWidget {
  const _WaitingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
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
