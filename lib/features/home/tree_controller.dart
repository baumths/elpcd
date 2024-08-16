part of 'tree_view.dart';

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
