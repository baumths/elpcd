import 'package:elpcd/entities/classe.dart';
import 'package:elpcd/features/class_editor/class_editor.dart';
import 'package:elpcd/features/class_editor/earq_brasil_metadata.dart';
import 'package:elpcd/repositories/classes_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClassesRepository extends Mock implements ClassesRepository {}

void main() {
  late ClassesRepository repository;

  setUp(() {
    repository = MockClassesRepository();
  });

  ClassEditor createSubject({int? parentId}) =>
      ClassEditor(repository: repository, parentId: parentId);

  test('ClassEditor properly sets the parentId property when constructed', () {
    var subject = createSubject(parentId: 0);
    expect(subject.parentId, 0);

    subject = ClassEditor(repository: repository);
    expect(subject.parentId, Classe.rootId);
  });

  group('init()', () {
    test('updates EarqBrasilMetadata.subordinacao for new classes', () {
      final subject = createSubject(parentId: 0);
      when(() => repository.buildReferenceCode(0)).thenReturn('T-00');

      expect(subject.valueOf(EarqBrasilMetadata.subordinacao), isNull);

      subject.init();

      expect(subject.valueOf(EarqBrasilMetadata.subordinacao), 'T-00');
    });
  });

  group('edit()', () {
    const parentCode = 'T';
    late ClassEditor subject;
    late Classe clazz;

    setUp(() {
      subject = createSubject();
      clazz = Classe(parentId: 0, name: '', code: '', metadata: {})..id = 1;

      when(() => repository.getClassById(clazz.id!)).thenReturn(clazz);
      when(() => repository.buildReferenceCode(clazz.parentId))
          .thenReturn(parentCode);
    });

    group('when given an invalid classId', () {
      test('does not update editingClassId', () {
        expect(subject.editingClassId, isNull);
        subject.edit(42);
        expect(subject.editingClassId, isNull);
      });

      test('does not update parentId', () {
        expect(subject.parentId, Classe.rootId);
        subject.edit(42);
        expect(subject.parentId, Classe.rootId);
      });

      test('does not update any metadata', () {
        for (final metadata in EarqBrasilMetadata.values) {
          expect(subject.valueOf(metadata), isNull);
        }

        subject.edit(42);

        for (final metadata in EarqBrasilMetadata.values) {
          expect(subject.valueOf(metadata), isNull);
        }
      });
    });

    group('when given a valid classId', () {
      test('updates editingClassId', () {
        expect(subject.editingClassId, isNull);
        subject.edit(clazz.id!);
        expect(subject.editingClassId, clazz.id!);
      });

      test('updates parentId', () {
        expect(subject.parentId, Classe.rootId);
        subject.edit(clazz.id!);
        expect(subject.parentId, clazz.parentId);
      });

      test('updates all metadata', () {
        clazz.name = 'test name';
        clazz.code = 'test code';
        clazz.metadata = {
          for (final metadata in EarqBrasilMetadata.values)
            metadata.key: metadata.index.toString(),
        };

        for (final metadata in EarqBrasilMetadata.values) {
          expect(subject.valueOf(metadata), isNull);
        }

        subject.edit(clazz.id!);

        for (final metadata in EarqBrasilMetadata.values) {
          final expectedValue = switch (metadata) {
            EarqBrasilMetadata.nome => 'test name',
            EarqBrasilMetadata.codigo => 'test code',
            EarqBrasilMetadata.subordinacao => parentCode,
            final EarqBrasilMetadata other => other.index.toString(),
          };

          expect(subject.valueOf(metadata), expectedValue);
        }
      });
    });
  });

  test('updateValueOf() only updates the given metadata', () {
    final subject = createSubject();

    for (final metadata in EarqBrasilMetadata.values) {
      expect(subject.valueOf(metadata), isNull);
    }

    for (final metadata in EarqBrasilMetadata.values) {
      subject.updateValueOf(metadata, metadata.index.toString());

      for (int index = 0; index < EarqBrasilMetadata.values.length; index++) {
        expect(
          subject.valueOf(EarqBrasilMetadata.values[index]),
          index <= metadata.index ? index.toString() : isNull,
        );
      }
    }
  });

  group('save()', () {
    const parentCode = 'T';
    late ClassEditor subject;
    late Classe clazz;

    setUp(() {
      subject = createSubject();
      clazz = Classe(parentId: 0, name: '', code: '', metadata: {})..id = 1;

      when(() => repository.getClassById(clazz.id!)).thenReturn(clazz);
      when(() => repository.buildReferenceCode(clazz.parentId))
          .thenReturn(parentCode);

      registerFallbackValue(clazz);
      when(() => repository.save(any())).thenAnswer((_) async {});
    });

    test('creates new class when editingClassId is null', () {
      expect(subject.editingClassId, isNull);

      final result = subject.save();

      expect(result.id, isNull);
      expect(result.parentId, subject.parentId);
    });

    test('sets the Classe.parentId property when creating a new class', () {
      final subject = createSubject(parentId: 42);
      expect(subject.parentId, 42);

      final clazz = subject.save();
      expect(clazz.parentId, 42);
    });

    test('gets class from repository when editingClassId is not null', () {
      expect(subject.editingClassId, isNull);

      subject.edit(clazz.id!);
      verify(() => repository.getClassById(clazz.id!)).called(1);

      expect(subject.editingClassId, isNotNull);
      expect(subject.editingClassId, clazz.id!);

      subject.save();
      verify(() => repository.getClassById(clazz.id!)).called(1);
    });

    test('inserts new class into repository', () {
      subject.save();
      verifyNever(() => repository.getClassById(any()));
      verify(() => repository.save(any())).called(1);
    });

    test('updates existing class into repository', () {
      subject.edit(clazz.id!);
      subject.save();
      verify(() => repository.getClassById(clazz.id!)).called(2);
      verify(() => repository.save(clazz)).called(1);
    });
  });

  group('applyMetadata()', () {
    const parentCode = 'T';
    late ClassEditor subject;
    late Classe clazz;

    setUp(() {
      subject = createSubject();
      clazz = Classe(parentId: 0, name: '', code: '', metadata: {})..id = 1;

      when(() => repository.getClassById(clazz.id!)).thenReturn(clazz);
      when(() => repository.buildReferenceCode(clazz.parentId))
          .thenReturn(parentCode);
    });

    test('updates primary metadata', () {
      subject.edit(clazz.id!);

      expect(clazz.name, '');
      expect(clazz.code, '');

      subject.updateValueOf(EarqBrasilMetadata.nome, 'edited name');
      subject.updateValueOf(EarqBrasilMetadata.codigo, 'edited code');

      subject.applyMetadata(clazz);

      expect(clazz.name, 'edited name');
      expect(clazz.code, 'edited code');
    });

    test('excludes primary metadata from class.metadata', () {
      subject.edit(clazz.id!);

      expect(subject.valueOf(EarqBrasilMetadata.nome), '');
      expect(subject.valueOf(EarqBrasilMetadata.codigo), '');
      expect(subject.valueOf(EarqBrasilMetadata.subordinacao), parentCode);

      subject.applyMetadata(clazz);

      expect(clazz.metadata, isNot(contains(EarqBrasilMetadata.nome.key)));
      expect(clazz.metadata, isNot(contains(EarqBrasilMetadata.codigo.key)));
      expect(
          clazz.metadata, isNot(contains(EarqBrasilMetadata.subordinacao.key)));
    });

    test('edits only EarqBrasilMetadata, other metadata are ignored', () {
      clazz.metadata = {'unknown key': 'unknown value'};

      subject.edit(clazz.id!);

      expect(subject.metadata, contains('unknown key'));
      expect(subject.metadata['unknown key'], 'unknown value');

      subject.metadata['unknown key'] = 'edited unknown value';
      subject.applyMetadata(clazz);

      expect(clazz.metadata, contains('unknown key'));
      expect(clazz.metadata['unknown key'], isNot('edited unknown value'));
      expect(clazz.metadata['unknown key'], 'unknown value');
    });

    test('trims metadata values', () {
      clazz.name = '     \n ';
      clazz.code = ' \n     ';
      clazz.metadata = {
        for (final metadata in EarqBrasilMetadata.values)
          metadata.key: '\n   ${metadata.index}   \n',
      };

      subject.edit(clazz.id!);
      subject.applyMetadata(clazz);

      expect(clazz.name, isEmpty);
      expect(clazz.code, isEmpty);

      for (final value in clazz.metadata.values) {
        expect(value, matches(r'[0-9]+'));
      }
    });

    test('removes empty metadata from map', () {
      clazz.metadata = {
        for (final metadata in EarqBrasilMetadata.values)
          metadata.key: metadata.index.toString(),
      };

      subject.edit(clazz.id!);

      for (final metadata in EarqBrasilMetadata.values) {
        subject.updateValueOf(metadata, '\n \n');
      }

      expect(subject.metadata, hasLength(EarqBrasilMetadata.values.length));

      subject.applyMetadata(clazz);

      expect(subject.metadata, isEmpty);
      expect(clazz.metadata, isEmpty);
    });

    test('does not let EarqBrasilMetadata.subordination to leak through', () {
      clazz.metadata = {EarqBrasilMetadata.subordinacao.key: 'T-000'};

      subject.edit(clazz.id!);

      // The `T-000` value provided above should be overridden by the call to
      // updateSubordination() that happens inside edit().
      expect(subject.valueOf(EarqBrasilMetadata.subordinacao), parentCode);

      subject.applyMetadata(clazz);

      expect(subject.valueOf(EarqBrasilMetadata.subordinacao), isNull);
      expect(clazz.metadata[EarqBrasilMetadata.subordinacao.key], isNull);
    });
  });

  test('updateSubordination() updates the subordinacao metadata value', () {
    final subject = createSubject();
    when(() => repository.buildReferenceCode(0)).thenReturn('foo-bar');

    expect(subject.valueOf(EarqBrasilMetadata.subordinacao), isNull);

    subject.updateSubordination(0);

    verify(() => repository.buildReferenceCode(0)).called(1);
    expect(subject.valueOf(EarqBrasilMetadata.subordinacao), 'foo-bar');
  });
}
