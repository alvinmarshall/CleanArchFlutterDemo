import 'package:flutter/cupertino.dart';
import 'package:learncleanarch/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {@required id,
      @required name,
      @required username,
      @required email,
      @required phone})
      : super(
            id: id, name: name, username: username, email: email, phone: phone);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        phone: json['phone']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone
      };
}
