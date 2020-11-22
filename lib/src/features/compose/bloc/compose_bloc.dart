import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/entities.dart';
import '../../../repositories/hive_repository.dart';
import '../misc/metadata_viewmodel.dart';

part 'compose_event.dart';
part 'compose_state.dart';

class ComposeBloc extends Bloc<ComposeEvent, ComposeState> {
  ComposeBloc(this._repository) : super(ComposeState.initial());

  final HiveRepository _repository;

  //! BLOC exiting with null error

  @override
  Stream<ComposeState> mapEventToState(ComposeEvent event) async* {
    if (event is ComposeStarted) {
      if (event.classe == null) {
        yield state.copyWith(
          classe: Classe.root(),
        );
      } else {
        yield state.copyWith(
          classe: event.classe,
          name: event.classe.name,
          code: event.classe.code,
          metadata: metadataFromMap(event.classe.metadata),
          isEditing: true,
        );
      }
    } else if (event is NameChanged) {
      yield state.copyWith(name: event.name);
    } else if (event is CodeChanged) {
      yield state.copyWith(code: event.code);
    } else if (event is SavePressed) {
      yield state.copyWith(isSaving: true, shouldValidate: true);

      if (state.isFormValid) {
        await saveClasse(event.metadados);
        yield state.copyWith(
          isSaving: false,
          status: ComposeStatus.success,
        );
      } else {
        yield state.copyWith(
          isSaving: false,
          status: ComposeStatus.failure,
        );
      }
    }
  }

  Future<void> saveClasse(List<MetadataViewModel> metadata) async {
    final classe = state.classe
      ..name = state.name
      ..code = state.code
      ..metadata = metadataToMap(metadata);

    state.isEditing
        ? await _repository.update(classe)
        : await _repository.insert(classe);
  }

  Map<String, String> metadataToMap(List<MetadataViewModel> metadata) {
    return {
      for (final md in metadata)
        if (md.isNotEmpty) ...md.toMap()
    };
  }

  List<MetadataViewModel> metadataFromMap(Map<String, String> metadata) {
    return metadata.entries.map<MetadataViewModel>((md) {
      return MetadataViewModel(type: md.key, content: md.value);
    }).toList();
  }
}
