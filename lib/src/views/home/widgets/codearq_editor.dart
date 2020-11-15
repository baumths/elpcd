import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/shared.dart';
import '../home_controller.dart';

class CodearqEditor extends StatelessWidget {
  final double bottomSheetHeight = 60;
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: bottomSheetHeight,
        child: Row(
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
                style: context.theme.textTheme.headline5,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Digite aqui',
                  hintStyle: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            SizedBox(
              height: bottomSheetHeight,
              child: FlatButton.icon(
                icon: const Icon(Icons.check),
                label: Text(
                  'SALVAR',
                  style: context.theme.textTheme.headline6,
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
