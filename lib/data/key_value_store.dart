abstract interface class KeyValueStore {
  void delete(String key);
  T? read<T>(String key);
  void write(String key, Object value);
}

class InMemoryKeyValueStore implements KeyValueStore {
  final Map<String, Object> memory = {};

  @override
  void delete(String key) => memory.remove(key);

  @override
  T? read<T>(String key) => switch (memory[key]) {
        T? value => value,
        _ => null,
      };

  @override
  void write(String key, Object value) => memory[key];
}
