import '_indexeddb_backend.dart' as idb;
import 'hive_database.dart';

HiveDatabase open() => const HiveDatabaseWeb();

class HiveDatabaseWeb implements HiveDatabase {
  const HiveDatabaseWeb();

  @override
  Future<void> deleteFromDisk() async {
    await idb.deleteDatabase('classes');
    await idb.deleteDatabase('settings');
  }

  @override
  Future<List<ClassFromHive>> getAllClasses() async {
    final values = await idb.getAllValuesFromDatabase('classes');
    return values.whereType<ClassFromHive>().toList(growable: false);
  }

  @override
  Future<bool> hasClassesBox() async => await idb.databaseExists('classes');
}
