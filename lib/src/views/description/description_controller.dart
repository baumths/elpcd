import 'package:flutter/material.dart';

import '../../database/hive_database.dart';
import '../../models/pcd_model.dart';
import '../../shared/shared.dart';

enum DescriptionMode { viewClass, editClass, newClass }

class DescriptionController with ChangeNotifier {
  DescriptionController.viewClass({@required this.pcd})
      : mode = DescriptionMode.viewClass {
    isEditing = false;
  }

  DescriptionController.editClass({@required this.pcd})
      : mode = DescriptionMode.editClass {
    isEditing = true;
  }

  DescriptionController.newClass({this.parent})
      : mode = DescriptionMode.newClass {
    isEditing = true;
    pcd = PCDModel()
      ..subordinacao = parent?.codigo
      ..parentId = parent == null ? -1 : parent.legacyId;
  }

  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldState get scaffold => scaffoldKey.currentState;

  DescriptionMode mode;
  bool isEditing;
  bool isSaving = false;

  PCDModel pcd;
  PCDModel parent;

  // ignore: avoid_positional_boolean_parameters
  void toggleEditing(bool value) {
    isEditing = value;
    mode = value ? DescriptionMode.editClass : DescriptionMode.viewClass;
    notifyListeners();
  }

  // ignore: avoid_positional_boolean_parameters
  void toggleSaving(bool value) {
    isSaving = value;
    notifyListeners();
  }

  String validator(String value) {
    return value.trim().isEmpty ? 'Campo Obrigatório' : null;
  }

  Future<bool> validateForm() async {
    if (formKey.currentState.validate()) {
      toggleSaving(true); // Shows progress indicator

      formKey.currentState.save();
      await saveClass();

      toggleSaving(false); // Hides progress indicator
      return true;
    }
    return false;
  }

  Future<void> saveClass() async {
    if (mode == DescriptionMode.newClass) {
      await HiveDatabase.insertClass(pcd);
    } else {
      await pcd.save();
    }
  }

  Future<void> showDeleteDialog(BuildContext context) async {
    final bool delete = await showDialog(
      context: context,
      builder: (_) => AppDialogs.warning(
        context: context,
        title: 'Tem certeza?',
        btnText: 'APAGAR',
      ),
    );
    if (delete ?? false) {
      await pcd.delete();
      context.pop();
      ShowSnackBar.info(
        context,
        'A classe "${pcd.identifier}" foi apagada',
      );
    }
  }

  Future<void> showDiscardDialog({BuildContext context, bool shouldPop}) async {
    if (isEditing) {
      final bool discard = await showDialog(
        context: context,
        builder: (_) => AppDialogs.warning(
          context: context,
          title: 'Deseja descartar\nsuas alterações?',
          btnText: 'Descartar',
        ),
      );
      if (discard ?? false) {
        shouldPop ? context.pop() : toggleEditing(false);
      }
    } else {
      context.pop();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
