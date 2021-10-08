import 'package:flutter/services.dart' show PhysicalKeyboardKey;
import 'package:flutter/widgets.dart';

class CodearqController extends ValueNotifier<bool> {
  CodearqController({
    this.onSaved,
  }) : super(false) {
    focusNode = FocusNode(
      onKeyEvent: _onKeyEvent,
    )..addListener(onFocusChanged);
  }

  final ValueChanged<String>? onSaved;

  late final textEditingController = TextEditingController();
  late final FocusNode focusNode;

  String get text => textEditingController.text;
  set text(String newText) => textEditingController.text = newText;

  bool get isEditing => value;

  void disableEditing() => value = false;
  void enableEditing() => value = true;

  void save() {
    disableEditing();
    onSaved?.call(text);
  }

  void onFocusChanged() {
    if (focusNode.hasFocus) return;

    save();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

bool? _checkIsSubmitKey(PhysicalKeyboardKey key) {
  return <PhysicalKeyboardKey, bool>{
    PhysicalKeyboardKey.enter: true,
    PhysicalKeyboardKey.numpadEnter: true,
    PhysicalKeyboardKey.tab: true,
  }[key];
}

KeyEventResult _onKeyEvent(FocusNode focusNode, KeyEvent event) {
  final bool fieldSubmitted = _checkIsSubmitKey(event.physicalKey) ?? false;

  if (fieldSubmitted) {
    focusNode.unfocus();
    return KeyEventResult.handled;
  }
  return KeyEventResult.ignored;
}
