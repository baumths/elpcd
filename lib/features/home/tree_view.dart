import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../../app/navigator.dart' as navigator;
import '../../../entities/classe.dart';
import '../../../localization.dart';
import '../../repositories/classes_repository.dart';
import '../shared/class_title.dart';
import '../shared/classes_store.dart';

class ClassesTreeViewController {
  final treeController = TreeViewController();

  final Map<int, bool> _expansionStates = <int, bool>{};

  bool isExpanded(int? id) => _expansionStates[id] ?? false;

  @protected
  void updateExpansionState(int? id, bool state) {
    if (id == null) return;
    _expansionStates[id] = state;
  }
}

class ClassesExplorer extends StatefulWidget {
  const ClassesExplorer({super.key, required this.classesStore});

  final ClassesStore classesStore;

  @override
  State<ClassesExplorer> createState() => _ClassesExplorerState();
}

class _ClassesExplorerState extends State<ClassesExplorer> {
  late List<TreeViewNode<Classe>> tree = <TreeViewNode<Classe>>[];

  @override
  void initState() {
    super.initState();
    tree = buildTree();
    widget.classesStore.addListener(rebuildTree);
  }

  @override
  void dispose() {
    tree.clear();
    widget.classesStore.removeListener(rebuildTree);
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

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.titleMedium!,
      child: ClassesTreeView(tree: tree),
    );
  }

  List<TreeViewNode<Classe>> buildTree() {
    final controller = context.read<ClassesTreeViewController>();

    List<TreeViewNode<Classe>>? traverse(int? id) {
      return widget.classesStore.getSubclasses(id)?.map((Classe clazz) {
        return TreeViewNode<Classe>(
          clazz,
          children: traverse(clazz.id),
          expanded: controller.isExpanded(clazz.id),
        );
      }).toList();
    }

    return traverse(Classe.rootId) ?? <TreeViewNode<Classe>>[];
  }

  void rebuildTree() {
    if (mounted) {
      setState(() {
        tree = buildTree();
      });
    }
  }
}

class ClassesTreeView extends StatefulWidget {
  const ClassesTreeView({super.key, required this.tree});

  final List<TreeViewNode<Classe>> tree;

  static const Curve defaultAnimationCurve = Easing.standard;
  static const Duration defaultAnimationDuration = Durations.medium2;

  @override
  State<ClassesTreeView> createState() => _ClassesTreeViewState();
}

class _ClassesTreeViewState extends State<ClassesTreeView> {
  final Map<int, Map<Type, GestureRecognizerFactory>> _gestureRecognizers = {};
  int? hoveredClassId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<ClassesTreeViewController>();

    return TreeView(
      tree: widget.tree,
      controller: controller.treeController,
      treeNodeBuilder: (_, TreeViewNode<Classe> node, __) {
        return ClassesTreeViewNode(node: node);
      },
      treeRowBuilder: (TreeViewNode<Classe> node) {
        return TreeRow(
          extent: const FixedSpanExtent(40),
          cursor: SystemMouseCursors.click,
          onEnter: (_) => onCursorEnter(node.content.id),
          onExit: (_) => onCursorExit(node.content.id),
          recognizerFactories: gesturesOf(node.content.id),
          backgroundDecoration: hoveredClassId == node.content.id
              ? SpanDecoration(color: theme.hoverColor)
              : null,
        );
      },
      onNodeToggle: (TreeViewNode<Classe> node) {
        controller.updateExpansionState(node.content.id, node.isExpanded);
      },
      indentation: TreeViewIndentationType.custom(20),
      toggleAnimationStyle: AnimationStyle(
        curve: ClassesTreeView.defaultAnimationCurve,
        duration: ClassesTreeView.defaultAnimationDuration,
      ),
    );
  }

  Map<Type, GestureRecognizerFactory> gesturesOf(int? classId) {
    if (classId == null) return const {};

    return _gestureRecognizers[classId] ??= {
      TapGestureRecognizer: TreeViewTapGestureRecognizer(classId),
    };
  }

  void onCursorEnter(int? id) {
    if (id == hoveredClassId) return;
    setState(() {
      hoveredClassId = id;
    });
  }

  void onCursorExit(int? id) {
    if (id == hoveredClassId) {
      setState(() {
        hoveredClassId = null;
      });
    }
  }
}

class TreeViewTapGestureRecognizer
    extends GestureRecognizerFactory<TapGestureRecognizer> {
  const TreeViewTapGestureRecognizer(this.classId);

  final int? classId;

  @override
  TapGestureRecognizer constructor() => TapGestureRecognizer();

  @override
  void initializer(TapGestureRecognizer instance) =>
      instance..onTap = () => navigator.showClassEditor(classId: classId);
}

class ClassesTreeViewNode extends StatelessWidget {
  const ClassesTreeViewNode({super.key, required this.node});

  final TreeViewNode<Classe> node;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Row(
      children: <Widget>[
        IconButton(
          icon: AnimatedRotation(
            turns: node.isExpanded ? 0.25 : 0.0,
            curve: ClassesTreeView.defaultAnimationCurve,
            duration: ClassesTreeView.defaultAnimationDuration,
            child: const Icon(Icons.arrow_right_rounded),
          ),
          onPressed: node.children.isEmpty
              ? null
              : () => TreeViewController.of(context).toggleNode(node),
        ),
        ClassTitle(clazz: node.content),
        const SizedBox(width: 8),
        if (node.children.isEmpty)
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
                await repository.delete(node.content);
              }
            },
          ),
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: l10n.newSubordinateClassButtonText,
          onPressed: () => navigator.showClassEditor(
            parentId: node.content.id,
          ),
        ),
      ],
    );
  }
}
