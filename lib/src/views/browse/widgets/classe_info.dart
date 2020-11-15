import 'package:flutter/material.dart';

import '../../../models/pcd_model.dart';
import '../../../shared/shared.dart';

const String lorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
    'Nam dictum imperdiet nisi eget lobortis. Aenean nulla turpis, '
    'luctus at convallis ac, porta ac elit. Phasellus eu luctus massa, '
    'et semper mauris. Morbi orci urna, dapibus ac maximus in, semper vel.';

class ClasseInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pcd = ModalRoute.of(context).settings.arguments as PCDModel;
    return Scrollbar(
      radius: const Radius.circular(4),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        children: [
          const Divider(),
          _ClasseEntry(pcd.nome, pcd.destinacaoFinal),
          const Divider(),
          _ClasseEntry(pcd.nome, pcd.eventoCorrente),
          const Divider(),
          _ClasseEntry(pcd.nome, pcd.codigo),
          const Divider(),
          _ClasseEntry(pcd.nome, pcd.registroReativacao),
          const Divider(),
          _ClasseEntry(pcd.nome, pcd.observacoes),
          const Divider(),
          _ClasseEntry(pcd.nome, pcd.registroReativacao),
          const Divider(),
        ],
      ),
    );
  }
}

class _ClasseEntry extends StatelessWidget {
  const _ClasseEntry(this.title, this.content, {Key key}) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            title,
            style: TextStyle(
              color: context.theme.accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
          title: Text(content, style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
