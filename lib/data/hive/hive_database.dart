import 'binary_reader.dart' show ClassFromHive;

import '_hive.dart' if (dart.library.js_interop) '_hive_web.dart' as backend;

export 'binary_reader.dart' show ClassFromHive;

abstract interface class HiveDatabase {
  const HiveDatabase();

  Future<void> deleteFromDisk();
  Future<List<ClassFromHive>> getAllClasses();
  Future<bool> hasClassesBox();

  static Future<List<ClassFromHive>?> extractClasses() async {
    try {
      final hive = backend.open();
      final hasClassesBox = await hive.hasClassesBox();
      if (!hasClassesBox) return null;

      final classes = await hive.getAllClasses();
      await hive.deleteFromDisk();
      return classes;
    } on Object {
      return null;
    }
  }
}
