import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart';

import 'binary_reader.dart';

Future<Iterable<Object?>> getAllValuesFromDatabase(String name) async {
  final db = await openDatabase(name);
  final store = db.transaction('box'.toJS, 'readonly').objectStore('box');
  final result = await store.getAll(null).asFuture<JSArray>();
  db.close();
  return result.toDart.map(_decodeValue);
}

Future<IDBDatabase> openDatabase(String name) async {
  final request = window.self.indexedDB.open(name, 1);
  request.onupgradeneeded = (IDBVersionChangeEvent e) {
    final db = (e.target as IDBOpenDBRequest).result as IDBDatabase;
    if (!db.objectStoreNames.contains('box')) {
      db.createObjectStore('box');
    }
  }.toJS;

  return await request.asFuture<IDBDatabase>();
}

Future<bool> databaseExists(String name) async {
  final databases = await window.self.indexedDB.databases().toDart;
  for (final db in databases.toDart) {
    if (db.name == name) return true;
  }
  return false;
}

Future<void> deleteDatabase(String name) async {
  await window.self.indexedDB.deleteDatabase(name).asFuture<JSAny?>();
}

Object? _decodeValue(JSAny? value) {
  if (value.isA<JSArrayBuffer>()) {
    final bytes = Uint8List.view((value as JSArrayBuffer).toDart);
    if (_isEncoded(bytes)) {
      final reader = HiveBinaryReader(bytes);
      reader.skip(2);
      return reader.read();
    } else {
      return bytes;
    }
  } else {
    return value.dartify();
  }
}

const _bytePrefix = [0x90, 0xA9];

bool _isEncoded(Uint8List bytes) {
  return bytes.length >= _bytePrefix.length &&
      bytes[0] == _bytePrefix[0] &&
      bytes[1] == _bytePrefix[1];
}

extension IDBRequestExtension on IDBRequest {
  Future<T> asFuture<T extends JSAny?>() {
    final completer = Completer<T>();
    onsuccess = (Event e) {
      completer.complete(result as T);
    }.toJS;
    onerror = (Event e) {
      completer.completeError(error!);
    }.toJS;
    return completer.future;
  }
}
