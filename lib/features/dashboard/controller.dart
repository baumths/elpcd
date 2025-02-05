import 'package:flutter/foundation.dart';

enum DashboardTab {
  classification,
  temporality,
}

class DashboardController {
  final selectedTabNotifier = ValueNotifier(DashboardTab.classification);
  final sidebarVisibilityNotifier = ValueNotifier(true);

  void toggleSidebar() {
    sidebarVisibilityNotifier.value = !sidebarVisibilityNotifier.value;
  }

  void selectTab(DashboardTab tab) {
    selectedTabNotifier.value = tab;
  }

  void dispose() {
    selectedTabNotifier.dispose();
    sidebarVisibilityNotifier.dispose();
  }
}
