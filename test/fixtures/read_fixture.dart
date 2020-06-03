import 'dart:io';

String getFixture(String name) =>
    File("test/fixtures/$name").readAsStringSync();
