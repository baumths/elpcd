part of 'treeview.dart';

class TreeviewController extends ChangeNotifier {
  TreeviewController({bool allNodesExpanded = false}) {
    _treeController = TreeController(allNodesExpanded: allNodesExpanded);
  }

  TreeController _treeController;

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
