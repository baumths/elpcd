import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../schemes_list/schemes_list_page.dart';
import 'widgets/scaffold.dart';

abstract class AppRouter {
  static final _navigatorKey = GlobalKey<NavigatorState>();

  static final RouterConfig<Object> config = GoRouter(
    navigatorKey: _navigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppScaffold(body: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const SchemesListPage(),
          ),
        ],
      ),
    ],
  );
}
