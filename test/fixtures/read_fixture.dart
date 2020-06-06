import 'dart:io' show File, Directory;

import 'package:path/path.dart';

String getFixture(String name) {
  final testDirectory = join(
    Directory.current.path,
    Directory.current.path.endsWith('test') ? '' : 'test',
    'fixtures',
  );
  return File(join(testDirectory, "$name")).readAsStringSync();
}
