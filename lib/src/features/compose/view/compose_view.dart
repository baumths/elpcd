import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/entities.dart';
import '../misc/form_metadados.dart';
import 'widgets/widgets.dart';

class ComposeView extends StatelessWidget {
  const ComposeView({Key key, @required this.classe}) : super(key: key);

  static const routeName = '/compose';

  final Classe classe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compondo Classe'),
        actions: [
          IconButton(
            tooltip: 'Salvar',
            icon: const Icon(Icons.check),
            onPressed: () {
              // TODO: bloc event > SaveEvent
            },
          )
        ],
      ),
      body: ChangeNotifierProvider(
        create: (_) => FormMetadados(),
        child: Form(
          child: Scrollbar(
            radius: const Radius.circular(8),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: RequiredFields()),
                SliverToBoxAdapter(child: MetadadosList()),
                SliverToBoxAdapter(child: AddMetadados()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
