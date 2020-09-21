import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:elpcd_dart/src/managers/description_manager.dart';
import 'package:elpcd_dart/src/utils/utils.dart';
import 'package:elpcd_dart/src/views/views.dart';
import 'widgets/description_form.dart';

class DescriptionView extends StatelessWidget {
  DescriptionView(this.descriptionManager, {Key key})
      : assert(descriptionManager != null),
        super(key: key);

  final DescriptionManager descriptionManager;

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<DescriptionManager>(
      create: (_) => descriptionManager,
      dispose: (_, manager) => manager.dispose(),
      builder: (context, _) {
        return Consumer<DescriptionManager>(
          builder: (_, manager, __) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Descrição'),
                actions: getActions(context),
                leading: IconButton(
                  splashRadius: 24,
                  tooltip: 'Voltar',
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () async {
                    await descriptionManager.showDiscardDialog(
                      context: context,
                      shouldPop: true,
                    );
                  },
                ),
              ),
              floatingActionButton: this.descriptionManager.isSaving
                  ? const FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: const CircularProgressIndicator(),
                      onPressed: null,
                    )
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: DescriptionForm(),
            );
          },
        );
      },
    );
  }

  List<Widget> getActions(BuildContext context) {
    switch (this.descriptionManager.mode) {
      case DescriptionMode.editClass:
        return [
          this.saveButton(context),
        ];
      case DescriptionMode.viewClass:
        return [
          this.editButton(context),
          const SizedBox(width: 8),
          this.deleteButton(context),
          const SizedBox(width: 8),
        ];
      case DescriptionMode.newClass:
        return [
          this.saveButton(context),
        ];
      default:
        return [];
    }
  }

  Widget editButton(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      tooltip: 'Editar',
      icon: const Icon(Icons.edit),
      onPressed: () {
        this.descriptionManager.toggleEditing(true);
        ShowToast.info(context, 'Você entrou no modo de edição');
      },
    );
  }

  Widget deleteButton(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      tooltip: this.descriptionManager.pcd.hasChildren
          ? 'Não é possível apagar'
          : 'Apagar',
      icon: const Icon(Icons.delete),
      onPressed: this.descriptionManager.pcd.hasChildren
          ? null
          : () async => await this.descriptionManager.showDeleteDialog(context),
    );
  }

  Widget saveButton(BuildContext context) {
    return FlatButton.icon(
      label: Text('SALVAR', style: context.theme().textTheme.headline6),
      icon: const Icon(Icons.check, color: Colors.white),
      onPressed: () async {
        var valid = await this.descriptionManager.validateForm();
        if (valid) {
          context.pop();
          ShowToast.info(context, 'Classe salva com sucesso');
        } else {
          ShowToast.error(context, 'Não foi possível salvar a classe');
        }
      },
    );
  }
}
