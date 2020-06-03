import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("MoorUserModel")
class UserLocal extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text()();

  TextColumn get username => text()();

  TextColumn get email => text()();

  TextColumn get phone => text()();

  @override
  Set<Column> get primaryKey => {id};
}
