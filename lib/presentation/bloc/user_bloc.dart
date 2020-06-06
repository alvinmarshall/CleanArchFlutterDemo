import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:learncleanarch/domain/entities/user_entity.dart';
import 'package:learncleanarch/domain/usecase/base_usecase.dart';
import 'package:learncleanarch/domain/usecase/get_user_task.dart';
import 'package:learncleanarch/domain/usecase/get_users_task.dart';
import 'package:learncleanarch/utils/exception/exceptions.dart';
import 'package:learncleanarch/utils/failure.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserBlocState> {
  final GetUserTask getUserTask;
  final GetUsersTask getUsersTask;

  @override
  UserBlocState get initialState => EmptyUser();

  UserBloc({@required this.getUserTask, @required this.getUsersTask})
      : assert(getUserTask != null),
        assert(getUsersTask != null);

  @override
  Stream<UserBlocState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is GetUsersTaskEvent) {
      yield LoadingUser();
      final dataEither = await getUsersTask.call(NoParams());
      yield* _successUsersOrErrorState(dataEither);
    } else if (event is GetUserTaskEvent) {
      yield LoadingUser();
      final failureOrUser = await getUserTask.call(event.identifier);
      yield* _successUserOrErrorState(failureOrUser);
    }
  }

  Stream<UserBlocState> _successUsersOrErrorState(
      Either<Failure, List<UserEntity>> dataEither) async* {
    yield dataEither.fold(
        (failure) => ErrorUser(message: _failureMessage(failure)),
        (users) => SuccessUsers(usersList: users));
  }

  Stream<UserBlocState> _successUserOrErrorState(
      Either<Failure, UserEntity> failureOrUser) async* {
    yield failureOrUser.fold(
        (failure) => ErrorUser(message: _failureMessage(failure)),
        (user) => SuccessUser(userModel: user));
  }

  String _failureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ServerException.getServerErrorMessage;
      case CacheFailure:
        return CacheException.getCacheErrorMessage;
      default:
        return "An unknown error occurred";
    }
  }
}
