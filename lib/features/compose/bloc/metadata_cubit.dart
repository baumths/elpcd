import 'package:flutter_bloc/flutter_bloc.dart';

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
    try {
      state.firstWhere(
        (metadata) => metadata.type == type,
      );
    } on StateError {
      return false;
    }
    return true;
  }
}

const kMetadadosEArqBrasil = <String>{
  'Registro de Abertura',
  'Registro de Desativação',
  'Reativação da Classe',
  'Registro de Mudança de Nome de Classe',
  'Registro de Deslocamento de Classe',
  'Registro de Extinção',
  'Indicador de Classe Ativa/Inativa',
  'Prazo de Guarda na Fase Corrente',
  'Evento que Determina a Contagem do Prazo de Guarda na Fase Corrente',
  'Prazo de Guarda na Fase Intermediária',
  'Evento que Determina a Contagem do Prazo de Guarda na Fase Intermediária',
  'Destinação Final',
  'Registro de Alteração',
  'Observações',
};

class MetadataViewModel {
  MetadataViewModel({required this.type, this.content = ''});

  final String type;

  String content;

  bool get isEmpty => content.isEmpty;
  bool get isNotEmpty => content.isNotEmpty;
}
