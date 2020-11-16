import 'package:flutter/material.dart';

import '../../../entities/entities.dart';

class MetadadosCard extends StatelessWidget {
  const MetadadosCard({Key key, @required this.metadado}) : super(key: key);

  final Metadado metadado;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        title: TextFormField(
          initialValue: metadado.content,
          onChanged: (value) => metadado.content = value,
          decoration: InputDecoration(
            labelText: metadado.label,
            border: InputBorder.none,
          ),
        ),
        leading: IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.delete),
          onPressed: () {},
        ),
      ),
    );
  }
}
