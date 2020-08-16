import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:elpcd_dart/src/database/hive_database.dart';

class CodearqEditor extends StatelessWidget {
  final double bottomSheetHeight = 60;
  final _textController = TextEditingController();
  final settingsBox = Hive.box(HiveDatabase.settingsBox);

  Future<void> saveCodearq(BuildContext context, String value) async {
    String codearq = value.isEmpty ? 'ElPCD' : value;

    await settingsBox.put('codearq', codearq);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottomSheetHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.close),
            tooltip: 'Cancelar',
            splashRadius: 24,
            onPressed: Navigator.of(context).pop,
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _textController,
              autofocus: true,
              onSubmitted: (value) => saveCodearq(context, value),
              style: Theme.of(context).textTheme.headline5,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Digite um novo CODEARQ ...',
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Container(
            height: bottomSheetHeight,
            child: FlatButton.icon(
              icon: Icon(Icons.check),
              label: Text(
                'SALVAR',
                style: Theme.of(context).textTheme.headline6,
              ),
              onPressed: () => saveCodearq(context, _textController.text),
            ),
          ),
        ],
      ),
    );
  }
}
