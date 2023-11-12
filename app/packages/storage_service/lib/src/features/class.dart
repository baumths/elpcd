class Class {
  const Class({
    required this.id,
    required this.parentId,
    required this.name,
  });

  final String id;
  final String? parentId;
  final String name;
}

abstract interface class ClassesRepository {
  Future<Class?> getById(String id);
  Future<List<Class>> getChildren(String? id);
  Future<int> countChildren(String id, {bool recursive = false});

  Future<void> save(Class clazz);
  Future<Class?> delete(String id);

  Stream<Class> watch();
}
