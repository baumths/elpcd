import 'package:flutter/foundation.dart' show ValueListenable, ValueNotifier;

import '/repositories/entities_repository.dart';
import 'scheme_model.dart';

export 'scheme_model.dart';

sealed class SchemesListState {}

final class SchemesListLoading extends SchemesListState {}

final class SchemesListFailure extends SchemesListState {
  SchemesListFailure(this.message);
  final String message;
}

final class SchemesListSuccess extends SchemesListState {
  SchemesListSuccess(this.schemes);
  final List<Scheme> schemes;
}

class SchemesListController {
  SchemesListController({
    required EntitiesRepository entitiesRepository,
  })  : _entitiesRepository = entitiesRepository,
        _stateNotifier = ValueNotifier(SchemesListSuccess([]));

  final EntitiesRepository _entitiesRepository;

  Future<void> fetchSchemes() async {
    if (state is SchemesListLoading) return;
    _state = SchemesListLoading();

    try {
      final entities = await _entitiesRepository.getRoots();
      if (entities.isEmpty) {
        _state = SchemesListSuccess([]);
        return;
      }

      _state = SchemesListSuccess(
        entities.map(Scheme.fromEntity).toList(growable: false),
      );
    } on Exception catch (e) {
      _state = SchemesListFailure(e.toString());
    }
  }

  // TODO: move to its own controller to enable caching and exception handling
  Future<int> getClassCount(int schemeId) {
    return _entitiesRepository.countChildren(schemeId, recursive: true);
  }

  // TODO: once available, use macros to generate the following boilerplate

  final ValueNotifier<SchemesListState> _stateNotifier;

  ValueListenable<SchemesListState> get listenable => _stateNotifier;

  SchemesListState get state => _stateNotifier.value;

  set _state(SchemesListState newState) => _stateNotifier.value = newState;

  void dispose() {
    _stateNotifier.dispose();
  }
}
