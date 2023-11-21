import 'package:nanoid2/nanoid2.dart' show Alphabet, nanoid;

import 'features/class.dart';

abstract class StorageFacade {
  static String generateUniqueIdentifier() {
    return nanoid(length: 10, alphabet: Alphabet.noDoppelgangerSafe);
  }

  Future<void> init() => Future.value();
  Future<void> dispose() => Future.value();

  ClassesRepository get classesRepository;
}
