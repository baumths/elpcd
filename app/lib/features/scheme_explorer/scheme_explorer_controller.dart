import 'package:flutter/foundation.dart' show ValueNotifier, protected;
import 'package:storage_service/storage_service.dart';

extension ClassX on Class {
  Class copyWith({String? name}) {
    return Class(
      id: id,
      parentId: parentId,
      name: name ?? this.name,
    );
  }
}

sealed class SchemeExplorerState {}

final class SchemeExplorerInitial extends SchemeExplorerState {}

final class SchemeExplorerLoading extends SchemeExplorerState {}

final class SchemeExplorerSuccess extends SchemeExplorerState {
  SchemeExplorerSuccess({required this.scheme});
  final Class scheme;
}

sealed class SchemeExplorerFailure extends SchemeExplorerState {
  SchemeExplorerFailure({required this.schemeId});
  final String? schemeId;
}

final class SchemeIdNotFound extends SchemeExplorerFailure {
  SchemeIdNotFound({required super.schemeId});
}

final class InvalidSchemeId extends SchemeExplorerFailure {
  InvalidSchemeId({required super.schemeId});
}

final class DatabaseFailure extends SchemeExplorerFailure {
  DatabaseFailure({required super.schemeId, this.exception});
  final Object? exception;
}

class SchemeExplorerController extends ValueNotifier<SchemeExplorerState> {
  SchemeExplorerController({
    required ClassesRepository classesRepository,
  })  : _classesRepository = classesRepository,
        super(SchemeExplorerInitial());

  @protected
  @override
  set value(SchemeExplorerState newValue) => super.value = newValue;

  final ClassesRepository _classesRepository;

  Future<void> loadScheme(String? schemeId) async {
    if (value is SchemeExplorerLoading) return;
    value = SchemeExplorerLoading();
    value = await _mapSchemeIdToState(schemeId);
  }

  Future<void> updateSchemeName(String name) async {
    if (value case final SchemeExplorerSuccess state) {
      final updatedScheme = state.scheme.copyWith(name: name.trim());
      value = SchemeExplorerSuccess(scheme: updatedScheme);

      // TODO(chore): catch exceptions and wind back to previous scheme name
      //              then show failure snackbar/banner
      await _classesRepository.save(updatedScheme);
    }
  }

  Future<SchemeExplorerState> _mapSchemeIdToState(String? schemeId) async {
    if (schemeId == null) {
      return InvalidSchemeId(schemeId: schemeId);
    }

    try {
      final scheme = await _classesRepository.getById(schemeId);

      if (scheme == null) {
        return SchemeIdNotFound(schemeId: schemeId);
      }

      return SchemeExplorerSuccess(scheme: scheme);
    } on /* TODO(chore): ClassesRepositoryException */ Exception catch (e) {
      return DatabaseFailure(schemeId: schemeId, exception: e);
    }
  }
}
