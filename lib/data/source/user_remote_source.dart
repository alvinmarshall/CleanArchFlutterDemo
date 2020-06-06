import 'package:learncleanarch/data/model/user_model.dart';
import 'package:learncleanarch/data/service/api_service.dart';
import 'package:learncleanarch/utils/exception/exceptions.dart';
import 'package:learncleanarch/extension/user_dto_to_model.dart';

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
    var data = await _apiService.getUser(identifier);
    print(data);
    if (data.statusCode != getStatusOk) throw ServerException();
    return data.body.asModel;
  }

  @override
  Future<List<UserModel>> fetchUsers() async {
    var data = await _apiService.getUsers();
    print(data);
    if (data.statusCode != getStatusOk) throw ServerException();
    return data.body.toList().map((e) => e.asModel).toList(growable: true);
  }
}
