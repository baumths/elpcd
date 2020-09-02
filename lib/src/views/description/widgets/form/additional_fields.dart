part of '../description_form.dart';

class AdditionalFields extends StatelessWidget {
  const AdditionalFields(this.manager, {Key key})
      : assert(manager != null),
        super(key: key);

  final DescriptionManager manager;

  @override
  Widget build(BuildContext context) {
    bool readOnly = !manager.isEditing;
    return ExpansionTile(
      maintainState: true,
      title: const Text('Informações Adicionais'),
      childrenPadding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      children: [
        CustomFormField(
          labelText: 'Registro de Abertura',
          readOnly: readOnly,
          initialValue: manager.pcd.registroAbertura ?? '',
          onSaved: (val) => manager.pcd.registroAbertura = val.trim(),
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Registro de Desativação',
          readOnly: readOnly,
          initialValue: manager.pcd.registroDesativacao ?? '',
          onSaved: (val) => manager.pcd.registroDesativacao = val.trim(),
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Registro de Reativação',
          readOnly: readOnly,
          initialValue: manager.pcd.registroReativacao ?? '',
          onSaved: (val) => manager.pcd.registroReativacao = val.trim(),
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Registro de Mudança de Nome',
          readOnly: readOnly,
          initialValue: manager.pcd.registroMudancaNome ?? '',
          onSaved: (val) => manager.pcd.registroMudancaNome = val.trim(),
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Registro de Deslocamento',
          readOnly: readOnly,
          initialValue: manager.pcd.registroDeslocamento ?? '',
          onSaved: (val) => manager.pcd.registroDeslocamento = val.trim(),
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Registro de Extinção',
          readOnly: readOnly,
          initialValue: manager.pcd.registroExtincao ?? '',
          onSaved: (val) => manager.pcd.registroExtincao = val.trim(),
        ),
        const SizedBox(height: 8),
        IgnorePointer(
          ignoring: readOnly,
          child: DropdownField(
            readOnly: readOnly,
            selected: manager.pcd.indicador,
            values: ['ATIVA', 'INATIVA'],
            prefixText: 'Indicador de Classe',
            onSaved: (val) => manager.pcd.indicador = val,
          ),
        ),
      ],
    );
  }
}
