import 'dart:async' show StreamSubscription;

import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:provider/provider.dart';

import '../../../entities/classe.dart';
import '../../../repositories/classes_repository.dart';
import '../../../shared/dialogs.dart';
import '../../compose/compose.dart';

part 'tree_controller.dart';
part 'tree_node.dart';

class ClassesTreeView extends StatefulWidget {
  const ClassesTreeView({super.key, required this.repository});

  final ClassesRepository repository;

  @override
  State<ClassesTreeView> createState() => _ClassesTreeViewState();
}

class _ClassesTreeViewState extends State<ClassesTreeView> {
  StreamSubscription<Iterable<Classe>>? subscription;
  List<TreeNode>? tree;

  @override
  void initState() {
    super.initState();
    tree = buildTree(widget.repository.getAllClasses()) ?? <TreeNode>[];
    subscription = widget.repository.watchAllClasses().listen(onClassesChanged);
  }

  @override
  void dispose() {
    subscription?.cancel();
    subscription = null;
    tree = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (tree == null) {
      return const SizedBox.shrink();
    }

    if (tree!.isEmpty) {
      return Center(
        child: Text(
          'Crie uma Classe para começar',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      );
    }

    return Consumer<TreeviewController>(
      builder: (_, controller, __) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 72),
          child: TreeView(
            nodes: tree!,
            treeController: controller.treeController,
            indent: MediaQuery.sizeOf(context).width < 600 ? 8 : 24,
          ),
        );
      },
    );
  }

  void onClassesChanged(Iterable<Classe> classes) {
    if (!mounted) return;
    setState(() {
      tree = buildTree(classes);
    });
  }

  List<TreeNode>? buildTree(Iterable<Classe> classes) {
    final classesByParentId = <int, List<Classe>>{};

    for (final clazz in classes) {
      classesByParentId.update(
        clazz.parentId,
        (children) => children..add(clazz),
        ifAbsent: () => <Classe>[clazz],
      );
    }

    List<TreeNode>? buildChildren(int? parentId) {
      return classesByParentId[parentId]?.map((clazz) {
        return TreeNode(
          key: ValueKey(clazz.id),
          children: buildChildren(clazz.id),
          content: TreeNodeWidget(
            classe: clazz,
            hasChildren: classesByParentId[clazz.id]?.isNotEmpty ?? false,
          ),
        );
      }).toList();
    }

    return buildChildren(Classe.rootId);
  }
}
