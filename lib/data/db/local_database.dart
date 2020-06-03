
import 'package:learncleanarch/data/db/dao/user_dao.dart';
import 'package:learncleanarch/data/db/model/user_local.dart';
import 'package:learncleanarch/utils/constants.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'local_database.g.dart';
@UseMoor(tables: [UserLocal],daos: [UserDao])
class LocalDatabase extends _$LocalDatabase{
  LocalDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(path: DATABASE_NAME));

  @override
  int get schemaVersion => 1;
}