import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:learncleanarch/data/model/user_model.dart';

abstract class UserBlocState extends Equatable {
  @override
  List<Object> get props => [];
}

class EmptyUser extends UserBlocState {}

class LoadingUser extends UserBlocState {}

class ErrorUser extends UserBlocState {
  final String message;

  ErrorUser({@required this.message});

  @override
  List<Object> get props => [message];
}

class SuccessUsers extends UserBlocState {
  final List<UserModel> usersList;

  SuccessUsers({@required this.usersList});

  @override
  List<Object> get props => [usersList];
}

class SuccessUser extends UserBlocState {
  final UserModel userModel;

  SuccessUser({@required this.userModel});

  @override
  List<Object> get props => [userModel];
}
