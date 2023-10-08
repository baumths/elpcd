part of 'compose_bloc.dart';

enum ComposeStatus { none, success, failure }

@immutable
class ComposeState extends Equatable {
  const ComposeState({
    this.classe,
    required this.name,
    required this.code,
    required this.metadata,
    required this.isEditing,
    required this.isSaving,
    required this.shouldValidate,
    required this.status,
  });

  final Classe? classe;
  final String name;
  final String code;
  final Set<MetadataViewModel> metadata;
  final bool isEditing;
  final bool isSaving;
  final bool shouldValidate;
  final ComposeStatus status;

  factory ComposeState.initial() {
    return const ComposeState(
      classe: null,
      name: '',
      code: '',
      metadata: <MetadataViewModel>{},
      isEditing: false,
      isSaving: false,
      shouldValidate: false,
      status: ComposeStatus.none,
    );
  }

  bool get nameInvalid => shouldValidate && name.isEmpty;
  bool get codeInvalid => shouldValidate && code.isEmpty;
  bool get isFormValid => name.isNotEmpty && code.isNotEmpty;

  @override
  List<Object> get props {
    return [
      if (classe != null) classe!,
      name,
      code,
      metadata,
      isSaving,
      isEditing,
      shouldValidate,
      status,
    ];
  }

  ComposeState copyWith({
    Classe? classe,
    String? name,
    String? code,
    Set<MetadataViewModel>? metadata,
    bool? isEditing,
    bool? isSaving,
    bool? shouldValidate,
    ComposeStatus? status,
  }) {
    return ComposeState(
      classe: classe ?? this.classe,
      name: name ?? this.name,
      code: code ?? this.code,
      metadata: metadata ?? this.metadata,
      isEditing: isEditing ?? this.isEditing,
      isSaving: isSaving ?? this.isSaving,
      shouldValidate: shouldValidate ?? this.shouldValidate,
      status: status ?? this.status,
    );
  }
}
