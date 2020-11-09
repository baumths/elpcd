import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/shared.dart';

import 'description_controller.dart';
import 'widgets/widgets.dart';

class DescriptionView extends StatelessWidget {
  DescriptionView(this.controller, {Key key})
      : assert(controller != null),
        super(key: key);

  final DescriptionController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<DescriptionController>(
      create: (_) => controller,
      dispose: (_, controller) => controller.dispose(),
      builder: (context, _) {
        return Scaffold(
          key: context.watch<DescriptionController>().scaffoldKey,
          appBar: AppBar(
            title: const Text('Descrição'),
            actions: getActions(context),
            leading: IconButton(
              splashRadius: 24,
              tooltip: 'Voltar',
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                await controller.showDiscardDialog(
                  context: context,
                  shouldPop: true,
                );
              },
            ),
          ),
          floatingActionButton: this.controller.isSaving
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
  }

  List<Widget> getActions(BuildContext context) {
    switch (this.controller.mode) {
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
        this.controller.toggleEditing(true);
        ShowSnackBar.info(
          context,
          'Você entrou no modo de edição',
          duration: 2,
        );
      },
    );
  }

  Widget deleteButton(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      tooltip:
          this.controller.pcd.hasChildren ? 'Não é possível apagar' : 'Apagar',
      icon: const Icon(Icons.delete),
      onPressed: this.controller.pcd.hasChildren
          ? null
          : () async => await this.controller.showDeleteDialog(context),
    );
  }

  Widget saveButton(BuildContext context) {
    return FlatButton.icon(
      label: Text(
        'SALVAR',
        style: context.theme().textTheme.headline6.copyWith(
              color: Colors.white,
            ),
      ),
      icon: const Icon(Icons.check, color: Colors.white),
      onPressed: () async {
        var valid = await this.controller.validateForm();
        if (valid) {
          context.pop();
          ShowSnackBar.info(context, 'Classe salva com sucesso', duration: 2);
        } else {
          ShowSnackBar.error(context, 'Não foi possível salvar a classe');
        }
      },
    );
  }
}
