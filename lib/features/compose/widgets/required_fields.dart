import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/compose_bloc.dart';

class RequiredFields extends StatelessWidget {
  const RequiredFields({super.key});

  static const codeFormFieldKey = GlobalObjectKey('Compose.codeFormField');
  static const nameFormFieldKey = GlobalObjectKey('Compose.nameFormField');

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Metadados Obrigatórios',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (MediaQuery.sizeOf(context).width >= 600)
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: _CodeFormField(key: codeFormFieldKey),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 7,
                    child: _NameFormField(key: nameFormFieldKey),
                  ),
                ],
              )
            else ...[
              const _CodeFormField(key: codeFormFieldKey),
              const SizedBox(height: 12),
              const _NameFormField(key: nameFormFieldKey),
            ],
          ],
        ),
      ),
    );
  }
}

class _CodeFormField extends StatefulWidget {
  const _CodeFormField({super.key});

  @override
  _CodeFormFieldState createState() => _CodeFormFieldState();
}

class _CodeFormFieldState extends State<_CodeFormField> {
  final _textController = TextEditingController(text: '');

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComposeBloc, ComposeState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (_, state) => _textController.text = state.code,
      buildWhen: (p, c) =>
          p.code != c.code ||
          p.shouldValidate != c.shouldValidate ||
          p.status != c.status,
      builder: (_, state) {
        return TextFormField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: 'Código',
            errorText: state.codeInvalid ? 'Campo obrigatório' : null,
          ),
          onChanged: (value) {
            context.read<ComposeBloc>().add(CodeChanged(code: value.trim()));
          },
        );
      },
    );
  }
}

class _NameFormField extends StatefulWidget {
  const _NameFormField({super.key});

  @override
  _NameFormFieldState createState() => _NameFormFieldState();
}

class _NameFormFieldState extends State<_NameFormField> {
  final _textController = TextEditingController(text: '');

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComposeBloc, ComposeState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (_, state) => _textController.text = state.name,
      buildWhen: (p, c) =>
          p.name != c.name ||
          p.shouldValidate != c.shouldValidate ||
          p.status != c.status,
      builder: (_, state) {
        return TextFormField(
          maxLines: null,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Nome',
            errorText: state.nameInvalid ? 'Campo obrigatório' : null,
          ),
          onChanged: (value) {
            context.read<ComposeBloc>().add(NameChanged(name: value.trim()));
          },
        );
      },
    );
  }
}
