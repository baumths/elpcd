import 'package:flutter/material.dart';

import '../../database/hive_database.dart';
import '../../shared/shared.dart';

class HomeController with ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldState get scaffold => scaffoldKey.currentState;

  String _newCodearq = 'ElPCD';

  void changeCodearq(String value) {
    _newCodearq = value.trim().isEmpty ? 'ElPCD' : value.trim();
  }

  void navigationRequested(BuildContext context, String route, {Object args}) {
    Navigator.of(context).pushNamed(route, arguments: args);
  }

  Future<void> saveCodearq(BuildContext context) async {
    await HiveDatabase.settingsBox.put('codearq', _newCodearq);
    context.pop();
    ShowSnackBar.info(context, 'CODEARQ alterado para ➜ $_newCodearq');
  }
}
