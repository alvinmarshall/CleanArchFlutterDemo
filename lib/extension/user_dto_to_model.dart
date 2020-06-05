import 'package:learncleanarch/data/model/user_model.dart';
import 'package:learncleanarch/data/service/dto/user_dto.dart';

extension UserDtoToModel on UserDto {
  UserModel get asModel => UserModel.fromJson(UserDto((b) => b
    ..id = id
    ..name = name
    ..username = username
    ..email = email
    ..phone = phone).toJson());
}

extension UserModelToDto on UserModel {
  UserDto get asDto => UserDto.fromJson(this.toJson());
}
