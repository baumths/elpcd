import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/classe.dart';
import '../../../repositories/hive_repository.dart';
import 'metadata_cubit.dart';

part 'compose_event.dart';
part 'compose_state.dart';

class ComposeBloc extends Bloc<ComposeEvent, ComposeState> {
  ComposeBloc(this._repository) : super(ComposeState.initial()) {
    on<ComposeStarted>(_onStarted);
    on<NameChanged>(_onNameChanged);
    on<CodeChanged>(_onCodeChanged);
    on<SavePressed>(_onSavePressed);
  }

  final HiveRepository _repository;

  void _onStarted(ComposeStarted event, Emitter<ComposeState> emit) {
    if (event.classe != state.classe) {
      emit(state.copyWith(
        classe: event.classe,
        name: event.classe.name,
        code: event.classe.code,
        metadata: metadataFromMap(event.classe.metadata),
        isEditing: true,
      ));
    }
  }

  void _onNameChanged(NameChanged event, Emitter<ComposeState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onCodeChanged(CodeChanged event, Emitter<ComposeState> emit) {
    emit(state.copyWith(code: event.code));
  }

  Future<void> _onSavePressed(
    SavePressed event,
    Emitter<ComposeState> emit,
  ) async {
    emit(state.copyWith(
      isSaving: true,
      shouldValidate: true,
      status: ComposeStatus.none,
    ));

    if (state.isFormValid) {
      await saveClasse(event.metadata);
      emit(state.copyWith(
        isSaving: false,
        status: ComposeStatus.success,
      ));
    } else {
      emit(state.copyWith(
        isSaving: false,
        status: ComposeStatus.failure,
      ));
    }
  }

  Future<void> saveClasse(Set<MetadataViewModel> metadata) async {
    if (state.classe == null) return;

    final classe = state.classe!
      ..name = state.name
      ..code = state.code
      ..metadata = metadataToMap(metadata);
    await _repository.upsert(classe);
  }

  Map<String, String> metadataToMap(Set<MetadataViewModel> metadata) {
    return <String, String>{
      for (final md in metadata)
        if (md.isNotEmpty) ...md.toMap()
    };
  }

  Set<MetadataViewModel> metadataFromMap(Map<String, String> metadata) {
    return metadata.entries.map<MetadataViewModel>((md) {
      return MetadataViewModel(type: md.key, content: md.value);
    }).toSet();
  }
}
