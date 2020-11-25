import 'package:flutter_bloc/flutter_bloc.dart';

import 'metadata_viewmodel.dart';

class MetadataCubit extends Cubit<Set<MetadataViewModel>> {
  MetadataCubit() : super(const <MetadataViewModel>{});

  static const kMaxMetadata = 14;

  bool get canAddMetadata => state.length < kMaxMetadata;

  void setInitialMetadata(Set<MetadataViewModel> metadata) => emit(metadata);

  void addMetadata(MetadataViewModel metadata) {
    emit(<MetadataViewModel>{metadata, ...state});
  }

  void deleteMetadata(MetadataViewModel metadata) {
    state.remove(metadata);
    emit(<MetadataViewModel>{...state});
  }

  bool isPresent(String type) {
    return state.firstWhere((md) => md.type == type, orElse: () => null) == null
        ? false
        : true;
  }
}
