import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({
    Key key,
    @required this.prefixText,
    @required this.values,
    @required this.onSaved,
    this.selected,
    this.readOnly = false,
  }) : super(key: key);

  final List<String> values;
  final String prefixText;
  final Function(String) onSaved;
  final bool readOnly;
  final String selected;

  @override
  Widget build(BuildContext context) {
    var _selected = selected ?? values[0];
    final _prefixText = '$prefixText ➜ ';
    return DropdownButtonFormField(
      onSaved: onSaved,
      value: _selected,
      onChanged: (String newValue) => _selected = newValue,
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
    final icon = readOnly ? Icons.lock_outline : Icons.expand_more;
    return context.isDarkMode()
        ? Icon(icon)
        : Icon(icon, color: Colors.black.withOpacity(0.4));
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key key,
    this.labelText,
    this.readOnly = false,
    this.initialValue = '',
    this.onSaved,
    this.validator,
  }) : super(key: key);

  final String labelText;
  final bool readOnly;
  final String initialValue;
  final Function(String) onSaved;
  final String Function(String) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onSaved: onSaved,
      initialValue: initialValue,
      validator: validator,
      minLines: 1,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: readOnly
            ? const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(Icons.lock_outline),
              )
            : null,
      ),
    );
  }
}
