import '_indexeddb_backend.dart' as idb;
import 'binary_reader.dart' show ClassFromHive;

/// Gets all classes from indexeddb and then deletes all databases.
Future<List<ClassFromHive>?> extractClassesFromHive() async {
  try {
    final databaseExists = await idb.databaseExists('classes');
    if (!databaseExists) {
      return null;
    }

    final values = await idb.getAllValuesFromDatabase('classes');
    final classes = values.whereType<ClassFromHive>().toList(growable: false);

    return classes;
  } on Object {
    return null;
  } finally {
    await idb.deleteDatabase('classes');
    await idb.deleteDatabase('settings');
  }
}
