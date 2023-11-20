import 'package:flutter/material.dart';

extension on TextEditingController {
  void selectAll() {
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

class FocusDrivenTextField extends StatefulWidget {
  const FocusDrivenTextField({
    super.key,
    this.initialText,
    required this.onLostFocus,
  });

  final String? initialText;
  final ValueChanged<String> onLostFocus;

  @override
  State<FocusDrivenTextField> createState() => _FocusDrivenTextFieldState();
}

class _FocusDrivenTextFieldState extends State<FocusDrivenTextField>
    with MaterialStateMixin {
  late final TextEditingController textController;
  late final FocusNode focusNode;

  bool get showIcon => isHovered && !focusNode.hasFocus;

  void onFocusChanged() {
    // setting state so the edit icon only shows when hovering and not editing
    setState(() {
      if (focusNode.hasFocus) {
        textController.selectAll();
      } else {
        widget.onLostFocus(textController.text);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.initialText);
    focusNode = FocusNode()..addListener(onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant FocusDrivenTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!focusNode.hasFocus) {
      textController.text = widget.initialText ?? '';
    }
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => addMaterialState(MaterialState.hovered),
      onExit: (_) => removeMaterialState(MaterialState.hovered),
      child: TextField(
        focusNode: focusNode,
        controller: textController,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(12),
          enabledBorder: enabledBorder(colorScheme.outlineVariant),
          focusedBorder: focusedBorder(colorScheme.outline),
          suffixIcon: showIcon ? const Icon(Icons.edit) : null,
        ),
      ),
    );
  }

  static const defaultBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(6)),
  );

  InputBorder enabledBorder(Color color) {
    return isHovered ? focusedBorder(color) : defaultBorder;
  }

  InputBorder focusedBorder(Color color) {
    return defaultBorder.copyWith(borderSide: BorderSide(color: color));
  }
}
