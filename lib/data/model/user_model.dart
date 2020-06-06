import 'package:flutter/cupertino.dart';
import 'package:learncleanarch/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel(
      {@required id,
      @required name,
      @required username,
      @required email,
      @required phone})
      : super(
            id: id, name: name, username: username, email: email, phone: phone);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
