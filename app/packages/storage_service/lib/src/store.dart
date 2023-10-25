abstract class Store<T> {
  Future<void> put(T object);

  Future<T?> get(String key);
  Stream<T> getWhere(bool Function(T object) condition);

  Future<T?> delete(String key);
}
