import 'package:flutter/material.dart';

import 'package:elpcd_dart/src/managers/managers.dart';
import 'package:elpcd_dart/src/models/pcd_model.dart';
import 'package:elpcd_dart/src/utils/utils.dart';
import 'package:elpcd_dart/src/views/views.dart';

part 'tree_node.dart';

class TreeView extends StatelessWidget {
  final List<PCDModel> data;
  final Function(PCDModel model) onTap;

  const TreeView({@required this.data, this.onTap}) : assert(data != null);

  /// Recursively build children nodes
  Future<List<TreeNode>> _generateTreeNodes(PCDModel model, int level) async {
    if (!model.hasChildren) return [];
    List<TreeNode> output = [];
    final children = await model.children;
    for (var child in children) {
      output.add(
        TreeNode(
          pcd: child,
          level: level,
          onTap: onTap,
          children: await _generateTreeNodes(child, level + 1),
        ),
      );
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      padding: const EdgeInsets.only(bottom: 72),
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, index) {
        final PCDModel pcd = data[index];
        return FutureBuilder(
          future: _generateTreeNodes(pcd, 1),
          builder: (_, AsyncSnapshot<List<TreeNode>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.done:
                if (!snapshot.hasData) continue loadingLabel;
                return TreeNode(
                  pcd: pcd,
                  level: 0,
                  onTap: this.onTap,
                  children: snapshot.data,
                );
              loadingLabel:
              case ConnectionState.none:
              case ConnectionState.waiting:
              default:
                return const LinearProgressIndicator();
            }
          },
        );
      },
    );
  }
}
