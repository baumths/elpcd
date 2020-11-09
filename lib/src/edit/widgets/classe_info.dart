import 'package:flutter/material.dart';

const String lorem =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam dictum imperdiet nisi eget lobortis. Aenean nulla turpis, luctus at convallis ac, porta ac elit. Phasellus eu luctus massa, et semper mauris. Morbi orci urna, dapibus ac maximus in, semper vel.';

class ClasseInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: ListView(
          children: [
            const Divider(),
            _ClasseEntry(),
            const Divider(),
            _ClasseEntry(),
            const Divider(),
            _ClasseEntry(),
            const Divider(),
            _ClasseEntry(),
            const Divider(),
            _ClasseEntry(),
            const Divider(),
            _ClasseEntry(),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class _ClasseEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            'Nome da Classe',
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ListTile(
          dense: true,
          contentPadding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
          title: Text(lorem, style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
