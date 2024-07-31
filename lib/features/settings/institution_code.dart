import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/navigator.dart' as navigator;
import '../../localization.dart';
import 'settings_controller.dart';

class InstitutionCodeListTile extends StatelessWidget {
  const InstitutionCodeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final code = context.select<SettingsController, String>(
      (controller) => controller.institutionCode,
    );
    return ListTile(
      title: Text(AppLocalizations.of(context).editInstitutionCodeButtonText),
      trailing: Badge(
        largeSize: 32,
        textColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        label: Text(
          code.length > 9 ? '${code.substring(0, 10)}...' : code,
        ),
      ),
      onTap: () => navigator.showInstitutionCodeEditor(
        context.read<SettingsController>(),
      ),
    );
  }
}

class InstitutionCodeEditor extends StatefulWidget {
  const InstitutionCodeEditor({
    super.key,
    required this.institutionCode,
    required this.onSubmitted,
    required this.onDismissed,
  });

  final String institutionCode;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onDismissed;

  @override
  State<InstitutionCodeEditor> createState() => _InstitutionCodeEditorState();
}

class _InstitutionCodeEditorState extends State<InstitutionCodeEditor> {
  late final textController =
      TextEditingController(text: widget.institutionCode);

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: MediaQuery.viewInsetsOf(context) + const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: l10n.cancelButtonText,
            onPressed: widget.onDismissed,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              autofocus: true,
              controller: textController,
              onSubmitted: widget.onSubmitted,
              decoration: const InputDecoration(
                hintText: defaultInstitutionCode,
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                border: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            onPressed: () => widget.onSubmitted(textController.text),
            child: Text(l10n.saveButtonText.toUpperCase()),
          ),
        ],
      ),
    );
  }
}
