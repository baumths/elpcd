import 'package:flutter/foundation.dart';

class BrowserTypeController extends ValueNotifier<String> {
  BrowserTypeController({
    required String initiallySelectedType,
    this.onChanged,
  }) : super(initiallySelectedType);

  final ValueChanged<String>? onChanged;

  String get selectedType => value;

  void select(String type) {
    value = type;

    onChanged?.call(selectedType);
  }
}
