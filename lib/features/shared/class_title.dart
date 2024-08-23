import 'package:flutter/material.dart';

import '../../entities/classe.dart';
import '../../localization.dart';

class ClassTitle extends StatelessWidget {
  const ClassTitle({super.key, required this.clazz});

  final Classe clazz;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          if (clazz.code.isNotEmpty) ...[
            TextSpan(
              text: clazz.code,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' - '),
          ],
          if (clazz.name.isEmpty)
            TextSpan(
              text: AppLocalizations.of(context).unnamedClass,
              style: const TextStyle(fontStyle: FontStyle.italic),
            )
          else
            TextSpan(text: clazz.name),
        ],
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
