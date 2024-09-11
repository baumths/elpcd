import 'package:sqlite3/common.dart' show CommonDatabase;

import '_connection.dart' as connection show connect;

Future<CommonDatabase> openSqliteDatabase() async {
  final db = await connection.connect();
  final version = db.userVersion;

  if (version == 0) {
    db.execute('''
      BEGIN;

      CREATE TABLE IF NOT EXISTS classes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        parent_id INTEGER NOT NULL REFERENCES classes(id),
        name TEXT,
        code TEXT,
        metadata TEXT
      );

      PRAGMA user_version = 1;
      COMMIT;
    ''');
  }

  return db;
}
