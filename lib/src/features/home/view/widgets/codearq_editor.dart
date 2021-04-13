import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/home_controller.dart';

class CodearqEditor extends StatelessWidget {
  const CodearqEditor({Key? key}) : super(key: key);

  static const double kBottomSheetHeight = 60;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: kBottomSheetHeight,
        child: Row(
          children: [
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Cancelar',
              splashRadius: 24,
              onPressed: Navigator.of(context).pop,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                onChanged: controller.changeCodearq,
                autofocus: true,
                onSubmitted: (_) async {
                  await controller.saveCodearq(context);
                },
                style: Theme.of(context).textTheme.headline5,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Digite aqui',
                  hintStyle: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            SizedBox(
              height: kBottomSheetHeight,
              child: TextButton.icon(
                icon: const Icon(Icons.check),
                label: Text(
                  'SALVAR',
                  style: Theme.of(context).textTheme.headline6,
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
