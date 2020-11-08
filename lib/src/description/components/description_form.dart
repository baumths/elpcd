import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../description.dart';

import 'components.dart';

//! TODO: REFACTOR THE ENTIRE FORM

class DescriptionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DescriptionController>(
      builder: (_, controller, __) {
        var readOnly = !controller.isEditing;
        var pcd = controller.pcd;
        return Form(
          key: controller.formKey,
          child: Scrollbar(
            radius: const Radius.circular(24),
            controller: controller.scrollController,
            thickness: 8,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 128),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              controller: controller.scrollController,
              children: [
                const ListTile(title: const Text('Campos Obrigatórios')),
                CustomFormField(
                  labelText: 'Nome da Classe',
                  readOnly: readOnly,
                  initialValue: pcd.nome ?? '',
                  onSaved: (val) => pcd.nome = val.trim() ?? '' ?? '',
                  validator: controller.validator,
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Código da Classe',
                  readOnly: readOnly,
                  initialValue: pcd.codigo ?? '',
                  onSaved: (val) => pcd.codigo = val.trim() ?? '',
                  validator: controller.validator,
                ),
                const ListTile(title: const Text('Informações Adicionais')),
                CustomFormField(
                  labelText: 'Registro de Abertura',
                  readOnly: readOnly,
                  initialValue: pcd.registroAbertura ?? '',
                  onSaved: (val) => pcd.registroAbertura = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Registro de Desativação',
                  readOnly: readOnly,
                  initialValue: pcd.registroDesativacao ?? '',
                  onSaved: (val) => pcd.registroDesativacao = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Registro de Reativação',
                  readOnly: readOnly,
                  initialValue: pcd.registroReativacao ?? '',
                  onSaved: (val) => pcd.registroReativacao = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Registro de Mudança de Nome',
                  readOnly: readOnly,
                  initialValue: pcd.registroMudancaNome ?? '',
                  onSaved: (val) => pcd.registroMudancaNome = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Registro de Deslocamento',
                  readOnly: readOnly,
                  initialValue: pcd.registroDeslocamento ?? '',
                  onSaved: (val) => pcd.registroDeslocamento = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Registro de Extinção',
                  readOnly: readOnly,
                  initialValue: pcd.registroExtincao ?? '',
                  onSaved: (val) => pcd.registroExtincao = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                IgnorePointer(
                  ignoring: readOnly,
                  child: DropdownField(
                    readOnly: readOnly,
                    selected: pcd.indicador,
                    values: ['Ativa', 'Inativa'],
                    prefixText: 'Indicador de Classe',
                    onSaved: (val) => pcd.indicador = val,
                  ),
                ),
                const ListTile(title: const Text('Temporalidade Documental')),
                CustomFormField(
                  labelText: 'Prazo de Guarda na Fase Corrente',
                  readOnly: readOnly,
                  initialValue: pcd.prazoCorrente ?? '',
                  onSaved: (val) => pcd.prazoCorrente = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Evento Fase Corrente',
                  readOnly: readOnly,
                  initialValue: pcd.eventoCorrente ?? '',
                  onSaved: (val) => pcd.eventoCorrente = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Prazo de Guarda na Fase Intermediária',
                  readOnly: readOnly,
                  initialValue: pcd.prazoIntermediaria ?? '',
                  onSaved: (val) => pcd.prazoIntermediaria = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Evento Fase Intermediária',
                  readOnly: readOnly,
                  initialValue: pcd.eventoIntermediaria ?? '',
                  onSaved: (val) => pcd.eventoIntermediaria = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                IgnorePointer(
                  ignoring: readOnly,
                  child: DropdownField(
                    readOnly: readOnly,
                    selected: pcd.destinacaoFinal,
                    values: ['Preservar', 'Eliminar'],
                    prefixText: 'Destinação Final',
                    onSaved: (val) => pcd.destinacaoFinal = val,
                  ),
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Registro de Alteração',
                  readOnly: readOnly,
                  initialValue: pcd.registroAlteracao ?? '',
                  onSaved: (val) => pcd.registroAlteracao = val.trim() ?? '',
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  labelText: 'Observações',
                  readOnly: readOnly,
                  initialValue: pcd.observacoes ?? '',
                  onSaved: (val) => pcd.observacoes = val.trim() ?? '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
