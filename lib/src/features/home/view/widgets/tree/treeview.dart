import 'package:elpcd_dart/src/entities/entities.dart';
import 'package:elpcd_dart/src/repositories/hive_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/shared.dart';
import '../../../../features.dart';

part 'tree_controller.dart';
part 'tree_node.dart';
part 'treeview_placeholder.dart';
part 'waiting_view.dart';

class Treeview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = context.watch<HiveRepository>();

    return ValueListenableBuilder<Box<Classe>>(
      valueListenable: repository.listenToClasses(),
      builder: (_, box, __) {
        if (box.isEmpty) return const _TreeViewPlaceholder();
        return FutureBuilder(
          future: _buildNodes(repository.fetch()),
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
          key: ValueKey(classe.id),
          children: classe.hasChildren
              ? await _buildNodes(classe.children)
              : const <TreeNode>[],
          content: TreeNodeWidget(classe: classe),
        )
    ];
  }
}
