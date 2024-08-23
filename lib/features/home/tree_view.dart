import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:provider/provider.dart';

import '../../../app/navigator.dart' as navigator;
import '../../../entities/classe.dart';
import '../../../localization.dart';
import '../../repositories/classes_repository.dart';
import '../shared/class_title.dart';
import '../shared/classes_store.dart';

class ClassesTreeViewController extends ChangeNotifier {
  final treeController = TreeController(allNodesExpanded: false);

  bool get allNodesExpanded => treeController.allNodesExpanded;

  void expandAll() {
    treeController.expandAll();
    notifyListeners();
  }

  void collapseAll() {
    treeController.collapseAll();
    notifyListeners();
  }
}

class ClassesTreeView extends StatefulWidget {
  const ClassesTreeView({super.key, required this.classesStore});

  final ClassesStore classesStore;

  @override
  State<ClassesTreeView> createState() => _ClassesTreeViewState();
}

class _ClassesTreeViewState extends State<ClassesTreeView> {
  late List<TreeNode> tree = <TreeNode>[];

  @override
  void initState() {
    super.initState();
    tree = buildTree();
    widget.classesStore.addListener(classesStoreListener);
  }

  @override
  void dispose() {
    tree.clear();
    widget.classesStore.removeListener(classesStoreListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (tree.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context).emptyClassesExplorerBodyText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      );
    }

    return Consumer<ClassesTreeViewController>(
      builder: (_, controller, __) {
        return DefaultTextStyle(
          style: Theme.of(context).textTheme.titleMedium!,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 72),
            child: TreeView(
              nodes: tree,
              treeController: controller.treeController,
              indent: MediaQuery.sizeOf(context).width < 600 ? 12 : 40,
            ),
          ),
        );
      },
    );
  }

  List<TreeNode> buildTree() {
    List<TreeNode>? traverse(int? id) {
      return widget.classesStore.getSubclasses(id)?.map((Classe clazz) {
        final children = traverse(clazz.id);
        return TreeNode(
          key: ValueKey(clazz.id),
          children: children,
          content: ClassesTreeViewNode(
            clazz: clazz,
            hasChildren: children?.isNotEmpty ?? false,
          ),
        );
      }).toList();
    }

    return traverse(Classe.rootId) ?? <TreeNode>[];
  }

  void classesStoreListener() {
    if (mounted) {
      setState(() {
        tree = buildTree();
      });
    }
  }
}

class ClassesTreeViewNode extends StatelessWidget {
  const ClassesTreeViewNode({
    super.key,
    required this.clazz,
    required this.hasChildren,
  });

  final Classe clazz;
  final bool hasChildren;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: () => navigator.showClassEditor(classId: clazz.id),
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(6)),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 8),
            Expanded(
              child: ClassTitle(clazz: clazz),
            ),
            if (!hasChildren)
              IconButton(
                tooltip: l10n.deleteButtonText,
                color: theme.colorScheme.error,
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final delete = await navigator.showWarningDialog(
                    title: l10n.areYouSureDialogTitle,
                    confirmButtonText: l10n.deleteButtonText,
                  );
                  if ((delete ?? false) && context.mounted) {
                    final repository = context.read<ClassesRepository>();
                    await repository.delete(clazz);
                  }
                },
              ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: l10n.newSubordinateClassButtonText,
              onPressed: () => navigator.showClassEditor(parentId: clazz.id),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
