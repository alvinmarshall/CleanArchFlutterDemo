import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserTaskEvent extends UserEvent {
  final int identifier;

  GetUserTaskEvent({@required this.identifier});

  @override
  List<Object> get props => [identifier];
}

class GetUsersTaskEvent extends UserEvent {}
