abstract class Store<T> {
  Future<void> put(T object);

  Future<T?> get(int id);
  Stream<T> getWhere(bool Function(T object) condition);

  Future<T?> delete(int id);
}
