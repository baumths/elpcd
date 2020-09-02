part of '../description_form.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({
    Key key,
    this.prefixText,
    this.selected,
    this.readOnly = false,
    @required this.values,
    @required this.onSaved,
  }) : super(key: key);

  final List<String> values;
  final String prefixText;
  final Function(String) onSaved;
  final bool readOnly;
  final String selected;

  @override
  Widget build(BuildContext context) {
    var _selected = this.selected ?? values[0];
    var _prefixText = this.prefixText != null ? this.prefixText + ' ➜ ' : '';
    return DropdownButtonFormField(
      onSaved: onSaved,
      value: _selected,
      onChanged: (newValue) => _selected = newValue,
      decoration: InputDecoration(prefixText: _prefixText),
      icon: _buildIcon(context),
      items: values
          .map(
            (String value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: context.accentColor),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildIcon(BuildContext context) {
    var icon = readOnly ? Icons.lock_outline : Icons.expand_more;
    return context.isDarkMode()
        ? Icon(icon)
        : Icon(icon, color: Colors.black.withOpacity(0.4));
  }
}

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key key,
    this.labelText,
    this.readOnly = false,
    this.initialValue = '',
    this.onSaved,
    this.validator,
  }) : super(key: key) {
    this._txtCtrl.text = initialValue;
  }

  final _txtCtrl = TextEditingController();
  final String labelText;
  final bool readOnly;
  final String initialValue;
  final Function(String) onSaved;
  final Function(String) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: _txtCtrl,
      onSaved: onSaved,
      validator: validator,
      minLines: 1,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: readOnly
              ? const Icon(Icons.lock_outline)
              : IconButton(
                  splashRadius: 20,
                  tooltip: 'Limpar Campo',
                  iconSize: 16,
                  icon: const Icon(Icons.close),
                  onPressed: _txtCtrl.clear,
                ),
        ),
      ),
    );
  }
}
