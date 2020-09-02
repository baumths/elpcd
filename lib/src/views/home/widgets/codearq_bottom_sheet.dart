part of '../home_view.dart';

class CodearqEditor extends StatelessWidget {
  final double bottomSheetHeight = 60;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var homeManager = context.watch<HomeManager>();
    return Container(
      height: bottomSheetHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Cancelar',
            splashRadius: 24,
            onPressed: context.pop,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _textController,
              autofocus: true,
              onSubmitted: (value) async {
                await homeManager.saveCodearq(context, value);
              },
              style: context.theme().textTheme.headline5,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Digite um novo CODEARQ ...',
                hintStyle: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Container(
            height: bottomSheetHeight,
            child: FlatButton.icon(
              icon: const Icon(Icons.check),
              label: Text(
                'SALVAR',
                style: context.theme().textTheme.headline6,
              ),
              onPressed: () async {
                await homeManager.saveCodearq(context, _textController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
