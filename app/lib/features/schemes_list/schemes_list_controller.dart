import 'dart:async';

import 'package:flutter/foundation.dart' show ValueListenable, ValueNotifier;
import 'package:storage_service/storage_service.dart';

sealed class SchemesListState {}

final class SchemesListLoading extends SchemesListState {}

final class SchemesListFailure extends SchemesListState {
  SchemesListFailure(this.message);
  final String message;
}

final class SchemesListSuccess extends SchemesListState {
  SchemesListSuccess(this.schemes);
  final List<Class> schemes;
}

class SchemesListController {
  SchemesListController({
    required ClassesRepository classesRepository,
  })  : _classesRepository = classesRepository,
        _stateNotifier = ValueNotifier(SchemesListSuccess([])) {
    _classesSubscription = _classesRepository
        .watch()
        .where((Class clazz) => clazz.parentId == null)
        .listen((_) => fetchSchemes());
  }

  late StreamSubscription<Class> _classesSubscription;
  final ClassesRepository _classesRepository;

  Future<void> fetchSchemes() async {
    if (state is SchemesListLoading) return;
    _state = SchemesListLoading();

    try {
      final classes = await _classesRepository.getChildren(null);
      if (classes.isEmpty) {
        _state = SchemesListSuccess([]);
        return;
      }

      _state = SchemesListSuccess(classes);
    } on Exception catch (e) {
      _state = SchemesListFailure(e.toString());
    }
  }

  // TODO: move to its own controller to enable caching and exception handling
  Future<int> getClassCount(String schemeId) {
    return _classesRepository.countChildren(schemeId, recursive: true);
  }

  // TODO: once available, use macros to generate the following boilerplate

  final ValueNotifier<SchemesListState> _stateNotifier;

  ValueListenable<SchemesListState> get listenable => _stateNotifier;

  SchemesListState get state => _stateNotifier.value;

  set _state(SchemesListState newState) => _stateNotifier.value = newState;

  void dispose() {
    _stateNotifier.dispose();
    _classesSubscription.cancel();
  }
}
