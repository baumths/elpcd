import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../localization.dart';
import '../app/navigator.dart' as navigator;
import 'settings_controller.dart';

class CodearqListTile extends StatelessWidget {
  const CodearqListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final codearq = context.select<SettingsController, String>(
      (controller) => controller.codearq,
    );
    return ListTile(
      title: Text(AppLocalizations.of(context).editCodearqButtonText),
      trailing: Badge(
        largeSize: 32,
        textColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        label: Text(
          codearq.length > 9 ? '${codearq.substring(0, 10)}...' : codearq,
        ),
      ),
      onTap: () => navigator.showCodearqEditor(
        context.read<SettingsController>(),
      ),
    );
  }
}

class CodearqEditor extends StatefulWidget {
  const CodearqEditor({
    super.key,
    required this.codearq,
    required this.onSubmitted,
    required this.onDismissed,
  });

  final String codearq;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onDismissed;

  @override
  State<CodearqEditor> createState() => _CodearqEditorState();
}

class _CodearqEditorState extends State<CodearqEditor> {
  late final textController = TextEditingController(text: widget.codearq);

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
                hintText: defaultCodearq,
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
