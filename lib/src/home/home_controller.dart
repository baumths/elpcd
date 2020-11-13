import 'package:flutter/material.dart';

import '../database/hive_database.dart';
import '../description/description.dart';
import '../shared/shared.dart';

class HomeController with ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldState get scaffold => scaffoldKey.currentState;

  String _newCodearq = 'ElPCD';

  void changeCodearq(String value) {
    this._newCodearq = value.trim().isEmpty ? 'ElPCD' : value.trim();
  }

  void openDescription(BuildContext context, DescriptionController ctrl) {
    context.display(DescriptionView(ctrl));
  }

  Future<void> saveCodearq(BuildContext context) async {
    await HiveDatabase.settingsBox.put('codearq', this._newCodearq);
    context.pop();
    ShowSnackBar.info(context, 'CODEARQ alterado para ➜ ${this._newCodearq}');
  }
}
