import 'package:flutter/material.dart';

import '../../../entities/entities.dart';
import '../../features.dart';

abstract class ElPCDRouter {
  static const home = HomeView.routeName;
  static const compose = ComposeView.routeName;

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ComposeView.routeName:
        final classe = settings.arguments as Classe;
        return MaterialPageRoute(builder: (_) => ComposeView(classe: classe));
        break;
      case HomeView.routeName:
      default:
        return MaterialPageRoute(builder: (_) => HomeView());
        break;
    }
  }
}
