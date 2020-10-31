import 'package:flutter/material.dart';

import 'package:elpcd_dart/src/database/hive_database.dart';
import 'package:elpcd_dart/src/models/pcd_model.dart';
import 'package:elpcd_dart/src/utils/utils.dart';
import 'package:elpcd_dart/src/views/views.dart';

enum DescriptionMode { viewClass, editClass, newClass }

class DescriptionManager with ChangeNotifier {
  DescriptionManager.viewClass({@required this.pcd})
      : mode = DescriptionMode.viewClass {
    this.isEditing = false;
  }

  DescriptionManager.editClass({@required this.pcd})
      : mode = DescriptionMode.editClass {
    this.isEditing = true;
  }

  DescriptionManager.newClass({this.parent}) : mode = DescriptionMode.newClass {
    this.isEditing = true;
    this.pcd = PCDModel()
      ..subordinacao = this.parent == null ? null : this.parent.codigo
      ..parentId = this.parent == null ? -1 : this.parent.legacyId;
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

  void toggleEditing(bool value) {
    this.isEditing = value;
    this.mode = value ? DescriptionMode.editClass : DescriptionMode.viewClass;
    notifyListeners();
  }

  void toggleSaving(bool value) {
    this.isSaving = value;
    notifyListeners();
  }

  String validator(String value) {
    return value.trim().isEmpty ? 'Campo Obrigatório' : null;
  }

  Future<bool> validateForm() async {
    if (this.formKey.currentState.validate()) {
      this.toggleSaving(true); // Shows progress indicator

      this.formKey.currentState.save();
      await this.saveClass();

      this.toggleSaving(false); // Hides progress indicator
      return true;
    }
    return false;
  }

  Future<void> saveClass() async {
    if (this.mode == DescriptionMode.newClass) {
      await HiveDatabase.insertPCD(this.pcd);
    } else {
      await this.pcd.save();
    }
  }

  Future<void> showDeleteDialog(BuildContext context) async {
    bool delete = await showDialog(
      context: context,
      builder: (_) => AppDialogs.warning(
        context: context,
        title: 'Tem certeza?',
        btnText: 'APAGAR',
      ),
    );
    if (delete ?? false) {
      await this.pcd.delete();
      context.pop();
      ShowSnackBar.info(
        context,
        'A classe "${this.pcd.identifier}" foi apagada',
      );
    }
  }

  Future<void> showDiscardDialog({BuildContext context, bool shouldPop}) async {
    if (this.isEditing) {
      bool discard = await showDialog(
        context: context,
        builder: (_) => AppDialogs.warning(
          context: context,
          title: 'Deseja descartar\nsuas alterações?',
          btnText: 'Descartar',
        ),
      );
      if (discard ?? false) {
        shouldPop ? context.pop() : this.toggleEditing(false);
      }
    } else {
      context.pop();
    }
  }

  @override
  void dispose() {
    this.scrollController.dispose();
    super.dispose();
  }
}
