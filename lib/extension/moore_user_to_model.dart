import 'package:learncleanarch/data/db/local_database.dart';
import 'package:learncleanarch/data/model/user_model.dart';

extension UserModelToMoorExtension on UserModel {
  MoorUserModel get asMoor => MoorUserModel(
      id: id, phone: phone, email: email, username: username, name: name);
}

extension MoorUserToModel on MoorUserModel {
  UserModel get asModel => UserModel(
      id: id, name: name, username: username, email: email, phone: phone);
}
