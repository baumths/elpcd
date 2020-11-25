import 'package:elpcd_dart/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../../entities/entities.dart';
import '../../../../../repositories/hive_repository.dart';
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
    final repository = RepositoryProvider.of<HiveRepository>(context);

    return ValueListenableBuilder<Box<Classe>>(
      valueListenable: repository.listenToClasses(),
      builder: (_, box, __) {
        if (box.isEmpty) return const _TreeViewPlaceholder();
        return FutureBuilder(
          future: _buildNodes(repository.fetch(parentsOnly: true)),
          builder: (_, AsyncSnapshot<List<TreeNode>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (!snapshot.hasData) continue loadingLabel;
                return _SetupTreeView(nodes: snapshot.data);
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

class _SetupTreeView extends StatelessWidget {
  const _SetupTreeView({
    Key key,
    @required this.nodes,
  }) : super(key: key);

  final List<TreeNode> nodes;

  @override
  Widget build(BuildContext context) {
    final isSmallDisplay = MediaQuery.of(context).size.width < 600;
    return Consumer<TreeviewController>(
      builder: (_, controller, __) {
        return Scrollbar(
          radius: const Radius.circular(24),
          thickness: 8,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 72),
            child: TreeView(
              indent: isSmallDisplay ? 8 : 24,
              treeController: controller.treeController,
              nodes: nodes,
            ),
          ),
        );
      },
    );
  }
}
