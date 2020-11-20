part of 'compose_bloc.dart';

enum ComposeSuccessOrFailure { none, success, failure }

@immutable
class ComposeState extends Equatable {
  const ComposeState({
    @required this.classe,
    @required this.name,
    @required this.code,
    @required this.metadados,
    @required this.isEditing,
    @required this.isSaving,
    @required this.successOrFailure,
  });
  final Classe classe;
  final String name;
  final String code;
  final List<Metadado> metadados;
  final bool isEditing;
  final bool isSaving;
  final ComposeSuccessOrFailure successOrFailure;

  factory ComposeState.initial() {
    return const ComposeState(
      classe: null,
      name: '',
      code: '',
      metadados: <Metadado>[],
      isEditing: false,
      isSaving: false,
      successOrFailure: ComposeSuccessOrFailure.none,
    );
  }

  String get nameError => name.isEmpty ? 'Campo Obrigatório' : null;
  String get codeError => code.isEmpty ? 'Campo Obrigatório' : null;
  bool get isFormValid {
    return name != null && name.isNotEmpty && code != null && code.isNotEmpty;
  }

  @override
  List<Object> get props {
    // Classe not added because it won't be changing
    return [
      name,
      code,
      metadados,
      isSaving,
      isEditing,
      successOrFailure,
    ];
  }

  ComposeState copyWith({
    Classe classe,
    String name,
    String code,
    List<Metadado> metadados,
    bool isEditing,
    bool isSaving,
    ComposeSuccessOrFailure successOrFailure,
  }) {
    return ComposeState(
      classe: classe ?? this.classe,
      name: name ?? this.name,
      code: code ?? this.code,
      metadados: metadados ?? this.metadados,
      isEditing: isEditing ?? this.isEditing,
      isSaving: isSaving ?? this.isSaving,
      successOrFailure: successOrFailure ?? this.successOrFailure,
    );
  }
}
