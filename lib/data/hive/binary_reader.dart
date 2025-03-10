import 'dart:convert';
import 'dart:typed_data';

extension type ClassFromHive(Map<int, Object?> _props) {
  int? get id => _props[0] as int?;
  int get parentId => _props[1] as int;
  String get name => _props[2] as String;
  String get code => _props[3] as String;
  Map<String, String> get metadata => (_props[5] as Map).cast<String, String>();

  static const int typeId = 0;

  static ClassFromHive fromBinaryReader(HiveBinaryReader reader) {
    final numOfFields = reader.readByte();
    return ClassFromHive({
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    });
  }
}

// Copied from:
// https://github.com/isar/hive/blob/v2.2.3/hive/lib/src/registry/type_registry_impl.dart#L55
const int reservedTypeIds = 32;

// Copided from:
// https://github.com/isar/hive/blob/v2.2.3/hive/lib/src/binary/binary_reader_impl.dart
class HiveBinaryReader {
  HiveBinaryReader(this._buffer)
      : _byteData = ByteData.view(_buffer.buffer, _buffer.offsetInBytes),
        _bufferLimit = _buffer.length;

  final Uint8List _buffer;
  final ByteData _byteData;

  final int _bufferLimit;
  int _offset = 0;

  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  int get availableBytes => _bufferLimit - _offset;

  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  void _requireBytes(int bytes) {
    if (_offset + bytes > _bufferLimit) {
      throw RangeError('[Hive] Not enough bytes available.');
    }
  }

  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  void skip(int bytes) {
    _requireBytes(bytes);
    _offset += bytes;
  }

  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  int readByte() {
    _requireBytes(1);
    return _buffer[_offset++];
  }

  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  Uint8List viewBytes(int bytes) {
    _requireBytes(bytes);
    _offset += bytes;
    return _buffer.view(_offset - bytes, bytes);
  }

  Uint8List peekBytes(int bytes) {
    _requireBytes(bytes);
    return _buffer.view(_offset, bytes);
  }

  int readWord() {
    _requireBytes(2);
    return _buffer[_offset++] | _buffer[_offset++] << 8;
  }

  int readInt32() {
    _requireBytes(4);
    _offset += 4;
    return _byteData.getInt32(_offset - 4, Endian.little);
  }

  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  int readUint32() {
    _requireBytes(4);
    _offset += 4;
    return _buffer.readUint32(_offset - 4);
  }

  /// Not part of public API
  int peekUint32() {
    _requireBytes(4);
    return _buffer.readUint32(_offset);
  }

  int readInt() {
    return readDouble().toInt();
  }

  double readDouble() {
    _requireBytes(8);
    var value = _byteData.getFloat64(_offset, Endian.little);
    _offset += 8;
    return value;
  }

  bool readBool() {
    return readByte() > 0;
  }

  String readString([int? byteCount]) {
    byteCount ??= readUint32();
    var view = viewBytes(byteCount);
    return utf8.decode(view);
  }

  Uint8List readByteList([int? length]) {
    length ??= readUint32();
    _requireBytes(length);
    var byteList = _buffer.sublist(_offset, _offset + length);
    _offset += length;
    return byteList;
  }

  List<int> readIntList([int? length]) {
    length ??= readUint32();
    _requireBytes(length * 8);
    var byteData = _byteData;
    var list = List<int>.filled(length, 0, growable: true);
    for (var i = 0; i < length; i++) {
      list[i] = byteData.getFloat64(_offset, Endian.little).toInt();
      _offset += 8;
    }
    return list;
  }

  List<double> readDoubleList([int? length]) {
    length ??= readUint32();
    _requireBytes(length * 8);
    var byteData = _byteData;
    var list = List<double>.filled(length, 0.0, growable: true);
    for (var i = 0; i < length; i++) {
      list[i] = byteData.getFloat64(_offset, Endian.little);
      _offset += 8;
    }
    return list;
  }

  List<bool> readBoolList([int? length]) {
    length ??= readUint32();
    _requireBytes(length);
    var list = List<bool>.filled(length, false, growable: true);
    for (var i = 0; i < length; i++) {
      list[i] = _buffer[_offset++] > 0;
    }
    return list;
  }

  List<String> readStringList([int? length]) {
    length ??= readUint32();
    var list = List<String>.filled(length, '', growable: true);
    for (var i = 0; i < length; i++) {
      list[i] = readString(null);
    }
    return list;
  }

  List<Object?> readList([int? length]) {
    length ??= readUint32();
    var list = List<Object?>.filled(length, null, growable: true);
    for (var i = 0; i < length; i++) {
      list[i] = read();
    }
    return list;
  }

  Map<Object?, Object?> readMap([int? length]) {
    length ??= readUint32();
    var map = <Object?, Object?>{};
    for (var i = 0; i < length; i++) {
      map[read()] = read();
    }
    return map;
  }

  Object? read() {
    final typeId = readByte();

    if (typeId == ClassFromHive.typeId + reservedTypeIds) {
      return ClassFromHive.fromBinaryReader(this);
    }

    return switch (typeId) {
      0 => null,
      1 => readInt(),
      2 => readDouble(),
      3 => readBool(),
      4 => readString(),
      5 => readByteList(),
      6 => readIntList(),
      7 => readDoubleList(),
      8 => readBoolList(),
      9 => readStringList(),
      10 => readList(),
      11 => readMap(),
      _ => null,
    };
  }
}

extension ListIntX on List<int> {
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  int readUint32(int offset) {
    return this[offset] |
        this[offset + 1] << 8 |
        this[offset + 2] << 16 |
        this[offset + 3] << 24;
  }
}

extension Uint8ListX on Uint8List {
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  Uint8List view(int offset, int bytes) {
    return Uint8List.view(buffer, offsetInBytes + offset, bytes);
  }
}
