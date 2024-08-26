import 'dart:async' show StreamSubscription;

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:stream_transform/stream_transform.dart' show RateLimit;

import '../../entities/classe.dart';
import '../../repositories/classes_repository.dart';

class ClassesStore with ChangeNotifier {
  ClassesStore({required ClassesRepository repository})
      : _repository = repository {
    _mapParentsToChildren(repository.getAllClasses());
    _subscription = repository
        .watchAllClasses()
        // Debounce needed as the repo currently emits two events on each
        // class insertion, which breaks the tree builders as the first
        // event is emitted before an id is assigned to the new class.
        .debounce(const Duration(milliseconds: 20))
        .listen(_onClassesChanged);
  }

  final ClassesRepository _repository;
  StreamSubscription<Iterable<Classe>>? _subscription;
  late var _classesByParentId = <int, List<Classe>>{};

  void _mapParentsToChildren(Iterable<Classe> classes) {
    final classesByParentId = <int, List<Classe>>{};

    for (final Classe clazz in classes) {
      classesByParentId.update(
        clazz.parentId,
        (children) => children..add(clazz),
        ifAbsent: () => <Classe>[clazz],
      );
    }

    _classesByParentId = classesByParentId;
  }

  void _onClassesChanged(Iterable<Classe> classes) {
    _mapParentsToChildren(classes);
    notifyListeners();
  }

  List<Classe>? getSubclasses(int? parentId) => _classesByParentId[parentId];

  Future<void> delete(Classe clazz) async {
    await _repository.delete(clazz);
  }

  bool get isEmpty => _classesByParentId.isEmpty;

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _classesByParentId.clear();
    super.dispose();
  }
}
