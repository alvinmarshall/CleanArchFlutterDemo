import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;

  UserEntity(
      {@required this.id,
      @required this.name,
      @required this.username,
      @required this.email,
      @required this.phone});

  @override
  List<Object> get props => [id, name, username, email, phone];

  @override
  String toString() {
    return "(id: $id,name: $name,username: $username,email: $email,phone: $phone )";
  }
}
