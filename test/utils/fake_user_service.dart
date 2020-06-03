import 'package:learncleanarch/data/model/user_model.dart';
import 'package:learncleanarch/domain/entities/user_entity.dart';

class FakeUserService {
  static List<UserEntity> getUsers() {
    return [
      UserEntity(
          id: 1,
          name: "any_name",
          email: "any_email",
          phone: "any_phone",
          username: "any_username")
    ];
  }

  static List<UserModel> getUserModel() {
    return [
      UserModel(
          id: 1,
          name: "any_name",
          email: "any_email",
          phone: "any_phone",
          username: "any_username")
    ];
  }
}
