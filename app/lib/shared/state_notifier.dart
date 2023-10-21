import 'package:flutter/foundation.dart';

class StateNotifier<T> {
  StateNotifier(T state) : _notifier = ValueNotifier<T>(state);

  final ValueNotifier<T> _notifier;
  ValueListenable<T> get listenable => _notifier;

  @protected
  set state(T newState) => _notifier.value = newState;
  T get state => _notifier.value;

  @mustCallSuper
  void dispose() => _notifier.dispose();
}
