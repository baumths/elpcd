part of '../description_form.dart';

class TTDFields extends StatelessWidget {
  const TTDFields(this.manager, {Key key})
      : assert(manager != null),
        super(key: key);

  final DescriptionManager manager;

  @override
  Widget build(BuildContext context) {
    bool readOnly = !manager.isEditing;
    return ExpansionTile(
      maintainState: true,
      title: const Text('Temporalidade Documental'),
      childrenPadding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      children: [
        CustomFormField(
          labelText: 'Prazo de Guarda na Fase Corrente',
          readOnly: readOnly,
          initialValue: manager.pcd.prazoCorrente ?? '',
          onSaved: (val) => manager.pcd.prazoCorrente = val.trim(),
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Evento Fase Corrente',
          readOnly: readOnly,
          initialValue: manager.pcd.eventoCorrente ?? '',
          onSaved: (val) => manager.pcd.eventoCorrente = val.trim(),
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Prazo de Guarda na Fase Intermediária',
          readOnly: readOnly,
          initialValue: manager.pcd.prazoIntermediaria ?? '',
          onSaved: (val) => manager.pcd.prazoIntermediaria = val.trim(),
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Evento Fase Intermediária',
          readOnly: readOnly,
          initialValue: manager.pcd.eventoIntermediaria ?? '',
          onSaved: (val) => manager.pcd.eventoIntermediaria = val.trim(),
        ),
        const SizedBox(height: 8),
        IgnorePointer(
          ignoring: readOnly,
          child: DropdownField(
            readOnly: readOnly,
            selected: manager.pcd.destinacaoFinal,
            values: ['PRESERVAR', 'ELIMINAR'],
            prefixText: 'Destinação Final',
            onSaved: (val) => manager.pcd.destinacaoFinal = val,
          ),
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Registro de Alteração',
          readOnly: readOnly,
          initialValue: manager.pcd.registroAlteracao ?? '',
          onSaved: (val) => manager.pcd.registroAlteracao = val.trim(),
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Observações',
          readOnly: readOnly,
          initialValue: manager.pcd.observacoes ?? '',
          onSaved: (val) => manager.pcd.observacoes = val.trim(),
        ),
      ],
    );
  }
}
