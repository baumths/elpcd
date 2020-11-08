import 'package:flutter/material.dart';

import '../shared/shared.dart';

import 'components/classe_info.dart';

class EditView extends StatelessWidget {
  static const routeName = '/edit';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode() ? null : Colors.grey[300],
      appBar: AppBar(
        title: const Text('Editando Classe'),
        leading: IconButton(
          splashRadius: 20,
          tooltip: 'Voltar',
          icon: const Icon(Icons.arrow_back),
          onPressed: Navigator.of(context).pop,
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ClasseInfo(),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: 512,
      child: Card(
        elevation: 4,
        child: ClasseInfo(),
      ),
    ).center();
  }
}
