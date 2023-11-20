import 'dart:async';

import 'package:flutter/foundation.dart' show ValueNotifier, protected;
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

class SchemesListController extends ValueNotifier<SchemesListState> {
  SchemesListController({
    required ClassesRepository classesRepository,
  })  : _classesRepository = classesRepository,
        super(SchemesListSuccess([])) {
    _classesSubscription = _classesRepository
        .watch()
        .where((Class clazz) => clazz.parentId == null)
        .listen((_) => fetchSchemes());
  }

  @protected
  @override
  set value(SchemesListState newValue) => super.value = newValue;

  StreamSubscription<Class>? _classesSubscription;
  final ClassesRepository _classesRepository;

  Future<void> fetchSchemes() async {
    if (value is SchemesListLoading) return;
    value = SchemesListLoading();

    try {
      final classes = await _classesRepository.getChildren(null);
      if (classes.isEmpty) {
        value = SchemesListSuccess([]);
        return;
      }

      value = SchemesListSuccess(classes);
    } on Exception catch (e) {
      value = SchemesListFailure(e.toString());
    }
  }

  // TODO: move to its own controller to enable caching and exception handling
  Future<int> getClassCount(String schemeId) {
    return _classesRepository.countChildren(schemeId, recursive: true);
  }

  @override
  void dispose() {
    _classesSubscription?.cancel();
    _classesSubscription = null;
    super.dispose();
  }
}
