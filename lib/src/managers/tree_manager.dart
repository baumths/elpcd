import 'package:flutter/foundation.dart';

import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class TreeManager extends ChangeNotifier {
  TreeManager({bool allNodesExpanded = false}) {
    this._treeController = TreeController(allNodesExpanded: allNodesExpanded);
  }

  TreeController _treeController;

  TreeController get treeController => this._treeController;

  bool get allNodesExpanded => this._treeController.allNodesExpanded;

  bool isNodeExpanded(Key key) => this._treeController.isNodeExpanded(key);

  void expandAll() {
    this._treeController.expandAll();
    notifyListeners();
  }

  void collapseAll() {
    this._treeController.collapseAll();
    notifyListeners();
  }

  void expandNode(Key key) {
    this._treeController.expandNode(key);
    notifyListeners();
  }

  void collapseNode(Key key) {
    this._treeController.collapseNode(key);
    notifyListeners();
  }
}
