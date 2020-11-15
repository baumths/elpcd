import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class ComposeView extends StatelessWidget {
  static const routeName = '/compose';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compondo Classe')),
      body: Column(
        children: [
          Form(
            child: Wrap(
              children: [
                SizedBox(width: 300, child: TextFormField()),
                SizedBox(width: 300, child: TextFormField()),
              ],
            ).expanded(),
          ),
        ],
      ),
    );
  }
}
