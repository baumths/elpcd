part of 'menu.dart';

class MenuController with ChangeNotifier {
  int _index = 0;

  /// The current selected index in [NavigationRail].
  ///
  /// This decides which of [Menu.destionations]'s content is currently showing.
  int get index => _index;

  set index(int value) {
    if (_index == value) return;

    // Unextend NavRail to avoid obstructing content
    _isRailExtended = false;
    _index = value;
    notifyListeners();
  }

  bool _isRailExtended = false;

  /// Controls wheter to extend or not the [NavigationRail].
  ///
  /// Used to show rail labels when hovering.
  bool get isRailExtended => _isRailExtended;

  set isRailExtended(bool value) {
    if (_isRailExtended == value) return;

    _isRailExtended = value;
    notifyListeners();
  }
}
