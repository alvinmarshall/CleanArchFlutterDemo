import 'package:learncleanarch/data/model/user_model.dart';

abstract class IUserRemoteSource {
  /// Calls Get https://jsonplaceholder.typicode.com/users endpoint
  ///
  /// Throws [ServerException] for all errors
  Future<List<UserModel>> fetchUsers();

  /// Calls Get https://jsonplaceholder.typicode.com/users/{id} endpoint
  ///
  /// Throws [ServerException] for all errors
  Future<UserModel> fetchUser(int identifier);
}

class UserRemoteSourceImpl implements IUserRemoteSource{
  @override
  Future<UserModel> fetchUser(int identifier) {
    // TODO: implement fetchUser
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> fetchUsers() {
    // TODO: implement fetchUsers
    throw UnimplementedError();
  }
}
