import 'hive_database.dart';

HiveDatabase open() => const HiveDatabaseNoop();

class HiveDatabaseNoop implements HiveDatabase {
  const HiveDatabaseNoop();

  @override
  Future<void> deleteFromDisk() async {}

  @override
  Future<List<ClassFromHive>> getAllClasses() async => <ClassFromHive>[];

  @override
  Future<bool> hasClassesBox() async => false;
}
