import 'package:learncleanarch/data/model/user_model.dart';
import 'package:learncleanarch/data/service/api_service.dart';
import 'package:learncleanarch/utils/exception/exceptions.dart';

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

class UserRemoteSourceImpl implements IUserRemoteSource {
  final ApiService _apiService;

  static int get getStatusOk => 200;

  UserRemoteSourceImpl(this._apiService);

  @override
  Future<UserModel> fetchUser(int identifier) async {
    var resp = await _apiService.getUser(identifier);
    if (resp.statusCode == getStatusOk) {
      return UserModel.fromJson(resp.body.toJson());
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> fetchUsers() async {
    var resp = await _apiService.getUsers();
    if (resp.statusCode == getStatusOk) {
      return resp.body.toList().map((e) => UserModel.fromJson(e.toJson()));
    } else {
      throw ServerException();
    }
  }
}
