import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_controller.dart';

class CodearqEditor extends StatelessWidget {
  const CodearqEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    return Padding(
      padding: MediaQuery.viewInsetsOf(context) +
          const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Cancelar',
            onPressed: Navigator.of(context).pop,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              autofocus: true,
              onChanged: controller.changeCodearq,
              onSubmitted: (_) async {
                await controller.saveCodearq(context);
              },
              decoration: const InputDecoration(
                hintText: 'ElPCD',
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            child: const Text('SALVAR'),
            onPressed: () async {
              await controller.saveCodearq(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
