import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../app/navigator.dart' as navigator;
import '../../localization.dart';
import '../../repositories/classes_repository.dart';
import '../../shared/snackbars.dart';
import 'class_editor.dart';
import 'earq_brasil_form.dart';

void _onSavePressed(BuildContext context) {
  try {
    context.read<ClassEditor>().save();
  } on Exception {
    showErrorSnackBar(
      context,
      AppLocalizations.of(context).unableToSaveClassSnackbarText,
    );
  } finally {
    navigator.closeClassEditor();
  }
}

class ClassEditorScreen extends StatefulWidget {
  const ClassEditorScreen({super.key, this.classId, this.parentId});

  final int? classId;
  final int? parentId;

  @override
  State<ClassEditorScreen> createState() => _ClassEditorScreenState();
}

class _ClassEditorScreenState extends State<ClassEditorScreen> {
  late final ClassEditor editor;

  @override
  void initState() {
    super.initState();
    editor = ClassEditor(
      repository: context.read<ClassesRepository>(),
      parentId: widget.parentId,
    )..init(editingClassId: widget.classId);
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ClassEditor>.value(
      value: editor,
      child: const Material(
        child: ClassEditorShortcuts(
          child: Column(
            children: [
              Expanded(child: EarqBrasilForm()),
              Divider(height: 1, thickness: 1),
              ClassEditorActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassEditorActionButtons extends StatelessWidget {
  const ClassEditorActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: navigator.closeClassEditor,
            child: Text(l10n.cancelButtonText),
          ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () => _onSavePressed(context),
            child: Text(l10n.saveButtonText),
          ),
        ],
      ),
    );
  }
}

class ClassEditorShortcuts extends StatelessWidget {
  const ClassEditorShortcuts({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        const SingleActivator(
          LogicalKeyboardKey.keyS,
          control: true,
          includeRepeats: false,
        ): VoidCallbackIntent(() => _onSavePressed(context)),
      },
      child: child,
    );
  }
}
