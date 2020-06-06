import 'package:flutter/cupertino.dart';
import 'package:learncleanarch/data/db/dao/user_dao.dart';
import 'package:learncleanarch/data/model/user_model.dart';
import 'package:learncleanarch/utils/exception/exceptions.dart';

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
  Future<List<UserModel>> getUsers() async {
    try {
      return await userDao.getUsers();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveUsers(List<UserModel> userModelList) async {
    print("saveUsers: $userModelList");
    try {
      userModelList.forEach((user) async {
        await userDao.addUser(user);
      });
    } catch (e) {
      throw CacheException();
    }
  }
}
