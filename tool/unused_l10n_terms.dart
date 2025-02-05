// ignore_for_file: avoid_print

import 'dart:convert' show JsonEncoder, jsonDecode;
import 'dart:io';

void main(List<String> args) {
  final terms = getTranslationTerms('./lib/localization/app_pt.arb');
  final dartFiles = listDartFilesUnderLib();
  final unusedTerms = findUnusedTerms(terms, dartFiles);

  if (unusedTerms.isEmpty) {
    print('No unused terms found.');
    exit(0);
  }

  if (args.contains('--remove')) {
    removeUnusedTerms(unusedTerms);
    print('Unused l10n terms removed from .arb files.');

    if (args.contains('--gen')) {
      print('Generating dart l10n files.');
      final result = Process.runSync('flutter', ['gen-l10n']);
      if (result.stderr case String stderr? when stderr.isNotEmpty) {
        print(stderr);
      } else if (result.stdout case String stdout? when stdout.isNotEmpty) {
        print(stdout);
      }
    }

    print('Please verify git status for changes.');
  } else {
    final sb = StringBuffer();
    sb.writeln('Unused l10n Terms:');
    for (final term in unusedTerms) {
      sb.write('- ');
      sb.writeln(term);
    }
    sb.write('To remove unused terms run with "--remove".');
    sb.write(' Also include "--gen" to generate dart l10n files.');
    print(sb.toString());
  }
}

Set<String> getTranslationTerms(String templateArbFilePath) {
  final arbTerms = <String>{};

  final content = File(templateArbFilePath).readAsStringSync();
  final map = jsonDecode(content) as Map<String, Object?>;

  for (final entry in map.entries) {
    if (entry.key.startsWith('@')) continue;
    arbTerms.add(entry.key);
  }

  return arbTerms;
}

List<FileSystemEntity> listDartFilesUnderLib() {
  return Directory('./lib')
      .listSync(recursive: true, followLinks: false)
      .where((entity) => entity.path.endsWith('.dart'))
      .toList();
}

Set<String> findUnusedTerms(
  Set<String> arbTerms,
  List<FileSystemEntity> files,
) {
  final unused = arbTerms.toSet();
  for (final file in files) {
    final content = File(file.path).readAsStringSync();
    for (final arb in arbTerms) {
      if (content.contains(arb)) {
        unused.remove(arb);
      }
    }
  }
  return unused;
}

void removeUnusedTerms(Set<String> unusedTerms) {
  for (final entity in listArbFiles()) {
    final file = File(entity.path);
    final arbMap = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
    unusedTerms.forEach(arbMap.remove);
    file.writeAsStringSync(jsonEncodePretty(arbMap));
  }
}

List<FileSystemEntity> listArbFiles() {
  return Directory('./lib/localization')
      .listSync(followLinks: false)
      .where((entity) => entity.path.endsWith('.arb'))
      .toList();
}

String jsonEncodePretty(Object object) {
  var encoder = const JsonEncoder.withIndent("  ");
  return encoder.convert(object);
}
