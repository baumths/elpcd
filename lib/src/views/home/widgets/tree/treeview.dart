import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../database/hive_database.dart';
import '../../../../models/pcd_model.dart';
import '../../../../shared/shared.dart';
import '../../../views.dart';

part 'tree_controller.dart';
part 'tree_node.dart';
part 'treeview_placeholder.dart';
part 'waiting_view.dart';

class Treeview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<PCDModel>>(
      valueListenable: HiveDatabase.pcdBox.listenable(),
      builder: (_, box, __) {
        if (box.isEmpty) return _TreeViewPlaceholder();
        return FutureBuilder(
          future: _buildNodes(HiveDatabase.getClasses()),
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
                return _WaitingView();
            }
          },
        );
      },
    );
  }

  Future<List<TreeNode>> _buildNodes(Iterable<PCDModel> holdings) async {
    return <TreeNode>[
      for (final pcd in holdings)
        TreeNode(
          key: ValueKey(pcd.legacyId),
          children: pcd.hasChildren
              ? await _buildNodes(pcd.children)
              : const <TreeNode>[],
          content: TreeNodeWidget(pcd: pcd),
        )
    ];
  }
}
