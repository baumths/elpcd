import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/shared.dart';
import '../home.dart';

class CodearqEditor extends StatelessWidget {
  final double bottomSheetHeight = 60;

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<HomeController>();
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
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
                onChanged: controller.changeCodearq,
                autofocus: true,
                onSubmitted: (_) async {
                  await controller.saveCodearq(context);
                },
                style: context.theme().textTheme.headline5,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Digite aqui',
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
                  await controller.saveCodearq(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
