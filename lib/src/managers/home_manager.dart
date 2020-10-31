import 'package:flutter/material.dart';

import 'package:elpcd_dart/src/views/description/description_view.dart';
import 'package:elpcd_dart/src/database/hive_database.dart';
import 'package:elpcd_dart/src/managers/managers.dart';
import 'package:elpcd_dart/src/views/views.dart';
import 'package:elpcd_dart/src/utils/utils.dart';

class HomeManager with ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldState get scaffold => scaffoldKey.currentState;

  String _newCodearq = 'ElPCD';

  void changeCodearq(String value) {
    this._newCodearq = value.trim().isEmpty ? 'ElPCD' : value.trim();
  }

  void openDescription(BuildContext context, DescriptionManager manager) {
    context.display(DescriptionView(manager));
  }

  Future<void> saveCodearq(BuildContext context) async {
    await HiveDatabase.settingsBox.put('codearq', this._newCodearq);
    context.pop();
    ShowSnackBar.info(context, 'CODEARQ alterado para ➜ ${this._newCodearq}');
  }
}
