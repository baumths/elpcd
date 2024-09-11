import 'package:path/path.dart' as path show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/common.dart' show CommonDatabase;
import 'package:sqlite3/sqlite3.dart' show sqlite3;

Future<CommonDatabase> connect() async {
  final supportDirectory = await getApplicationSupportDirectory();
  return sqlite3.open(path.join(supportDirectory.path, 'elpcd.sqlite3'));
}
