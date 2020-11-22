import 'package:elpcd_dart/src/entities/entities.dart';
import 'package:elpcd_dart/src/repositories/hive_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/shared.dart';
import '../../../../features.dart';

part 'tree_controller.dart';
part 'tree_node.dart';
part 'treeview_placeholder.dart';
part 'waiting_view.dart';

// TODO: Implement my own version of `flutter_simple_treeview`

class Treeview extends StatelessWidget {
  const Treeview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = context.watch<HiveRepository>();

    return ValueListenableBuilder<Box<Classe>>(
      valueListenable: HiveRepository.classesBox.listenable(),
      builder: (_, box, __) {
        if (box.isEmpty) return const _TreeViewPlaceholder();
        return FutureBuilder(
          future: _buildNodes(repository.fetch(parents: true)),
          builder: (_, AsyncSnapshot<List<TreeNode>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasData) continue loadingLabel;
                return Consumer<TreeviewController>(
                  builder: (_, controller, __) {
                    return Scrollbar(
                      radius: const Radius.circular(24),
                      thickness: 8,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 72),
                        child: TreeView(
                          indent: context.isSmallDisplay() ? 8 : 24,
                          treeController: controller.treeController,
                          nodes: snapshot.data,
                        ),
                      ),
                    );
                  },
                );
              loadingLabel:
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
              default:
                return const _WaitingView();
            }
          },
        );
      },
    );
  }

  Future<List<TreeNode>> _buildNodes(Iterable<Classe> classes) async {
    return <TreeNode>[
      for (final classe in classes)
        TreeNode(
          key: ValueKey('${classe.id}'),
          children: classe.hasChildren
              ? await _buildNodes(classe.children)
              : const <TreeNode>[],
          content: TreeNodeWidget(classe: classe),
        )
    ];
  }
}
