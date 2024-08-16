part of 'tree_view.dart';

class ClassesTreeViewController extends ChangeNotifier {
  ClassesTreeViewController({bool allNodesExpanded = false})
      : _treeController = TreeController(allNodesExpanded: allNodesExpanded);

  final TreeController _treeController;

  TreeController get treeController => _treeController;

  bool get allNodesExpanded => _treeController.allNodesExpanded;

  bool isNodeExpanded(Key key) => _treeController.isNodeExpanded(key);

  void expandAll() {
    _treeController.expandAll();
    notifyListeners();
  }

  void collapseAll() {
    _treeController.collapseAll();
    notifyListeners();
  }

  void expandNode(Key key) {
    _treeController.expandNode(key);
    notifyListeners();
  }

  void collapseNode(Key key) {
    _treeController.collapseNode(key);
    notifyListeners();
  }
}
