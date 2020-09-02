import 'package:flutter/material.dart';

import 'package:elpcd_dart/src/views/description/description_view.dart';
import 'package:elpcd_dart/src/database/hive_database.dart';
import 'package:elpcd_dart/src/managers/managers.dart';
import 'package:elpcd_dart/src/views/views.dart';
import 'package:elpcd_dart/src/utils/utils.dart';

class HomeManager with ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(SnackBar snackbar) {
    this.scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void openDescription(BuildContext context, DescriptionManager manager) {
    context.display(DescriptionView(manager));
  }

  Future<void> saveCodearq(BuildContext context, String value) async {
    String codearq = value.isEmpty ? 'ElPCD' : value;
    await HiveDatabase.settingsBox.put('codearq', codearq);
    context.pop();
    ShowToast.info(context, 'CODEARQ alterado para ➜ $codearq', duration: 3);
  }
}
