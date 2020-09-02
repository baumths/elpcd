part of '../description_form.dart';

class RequiredFields extends StatelessWidget {
  const RequiredFields(this.manager, {Key key})
      : assert(manager != null),
        super(key: key);

  final DescriptionManager manager;

  String validator(String value) {
    return value.trim().isEmpty ? 'Campo Obrigatório' : null;
  }

  @override
  Widget build(BuildContext context) {
    bool readOnly = !manager.isEditing;
    return ExpansionTile(
      maintainState: true,
      initiallyExpanded: true,
      title: const Text('Campos Obrigatórios'),
      childrenPadding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      children: <Widget>[
        CustomFormField(
          labelText: 'Nome da Classe',
          readOnly: readOnly,
          initialValue: manager.pcd.nome ?? '',
          onSaved: (val) => manager.pcd.nome = val.trim(),
          validator: this.validator,
        ),
        const SizedBox(height: 8),
        CustomFormField(
          labelText: 'Código da Classe',
          readOnly: readOnly,
          initialValue: manager.pcd.codigo ?? '',
          onSaved: (val) => manager.pcd.codigo = val.trim(),
          validator: this.validator,
        ),
      ],
    );
  }
}
