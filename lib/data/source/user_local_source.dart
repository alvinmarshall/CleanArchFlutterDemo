import 'package:flutter/cupertino.dart';
import 'package:learncleanarch/data/db/dao/user_dao.dart';
import 'package:learncleanarch/data/model/user_model.dart';

abstract class IUserLocalSource {
  Future<List<UserModel>> getUsers();

  Future<UserModel> getUser(int identifier);

  Future<void> saveUsers(List<UserModel> userModelList);
}

class UserLocalSourceImpl implements IUserLocalSource {
  final UserDao userDao;

  UserLocalSourceImpl({@required this.userDao});

  @override
  Future<UserModel> getUser(int identifier) async =>
      await userDao.getUser(identifier);

  @override
  Future<List<UserModel>> getUsers() async => await userDao.getUsers();

  @override
  Future<void> saveUsers(List<UserModel> userModelList) async {
    print("saveUsers: $userModelList");
    userModelList.forEach((user) async {
      await userDao.addUser(user);
    });
  }
}
