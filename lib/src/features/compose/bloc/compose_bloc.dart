import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/entities.dart';
import '../../../repositories/hive_repository.dart';

part 'compose_event.dart';
part 'compose_state.dart';

class ComposeBloc extends Bloc<ComposeEvent, ComposeState> {
  ComposeBloc(this._repository) : super(ComposeState.initial());

  final HiveRepository _repository;

  //! BLOC exiting with null error

  @override
  Stream<ComposeState> mapEventToState(ComposeEvent event) async* {
    if (event is ComposeStarted) {
      yield state.copyWith(
        classe: event.classe,
        name: event.classe.name,
        code: event.classe.code,
        metadados: event.classe.metadados,
        isEditing: true,
      );
    } else if (event is NameChanged) {
      yield state.copyWith(name: event.name);
    } else if (event is CodeChanged) {
      yield state.copyWith(code: event.code);
    } else if (event is SavePressed) {
      yield state.copyWith(
        isSaving: true,
        successOrFailure: ComposeSuccessOrFailure.none,
      );

      if (state.isFormValid) {
        Future.delayed(const Duration(seconds: 2)); //! remove
        await saveClasse(event.metadados);
        yield state.copyWith(
          isSaving: false,
          successOrFailure: ComposeSuccessOrFailure.success,
        );
      } else {
        yield state.copyWith(
          isSaving: false,
          successOrFailure: ComposeSuccessOrFailure.failure,
        );
      }
    }
  }

  Future<void> saveClasse(List<Metadado> metadados) async {
    final classe = state.classe
      ..name = state.name
      ..code = state.code
      ..referenceCode = _repository.buildReferenceCode(state.classe)
      ..metadados = clearEmptyMetadados(state.metadados);

    state.isEditing
        ? await _repository.update(classe)
        : await _repository.insert(classe);
  }

  List<Metadado> clearEmptyMetadados(List<Metadado> metadados) {
    return metadados.where((m) => m.content.isNotEmpty).toList();
  }
}
