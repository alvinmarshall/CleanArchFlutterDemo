import 'package:learncleanarch/data/db/local_database.dart';
import 'package:learncleanarch/data/db/model/user_local.dart';
import 'package:learncleanarch/data/model/user_model.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:learncleanarch/extension/moore_user_to_model.dart';

part 'user_dao.g.dart';

@UseDao(tables: [UserLocal])
class UserDao extends DatabaseAccessor<LocalDatabase> with _$UserDaoMixin {
  UserDao(LocalDatabase attachedDatabase) : super(attachedDatabase);

  Future<void> addUser(UserModel userModel) =>
      into(userLocal).insert(userModel.asMoor, mode: InsertMode.replace);

  Future<UserModel> getUser(int identifier) =>
      (select(userLocal)..where((tbl) => tbl.id.equals(identifier)))
          .map((user) => user.asModel)
          .getSingle();

  Future<List<UserModel>> getUsers() =>
      (select(userLocal)).map((user) => user.asModel).get();
}
