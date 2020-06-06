import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncleanarch/domain/usecase/base_usecase.dart';
import 'package:learncleanarch/domain/usecase/get_user_task.dart';
import 'package:learncleanarch/domain/usecase/get_users_task.dart';
import 'package:learncleanarch/presentation/bloc/bloc.dart';
import 'package:learncleanarch/utils/exception/exceptions.dart';
import 'package:learncleanarch/utils/failure.dart';
import 'package:mockito/mockito.dart';

import '../../utils/fake_user_service.dart';

class MockGetUsersTask extends Mock implements GetUsersTask {}

class MockGetUserTask extends Mock implements GetUserTask {}

void main() {
  MockGetUsersTask mockGetUsersTask;
  MockGetUserTask mockGetUserTask;
  UserBloc userBloc;
  const USER_IDENTIFIER = 1;

  setUp(() {
    mockGetUsersTask = MockGetUsersTask();
    mockGetUserTask = MockGetUserTask();
    userBloc =
        UserBloc(getUsersTask: mockGetUsersTask, getUserTask: mockGetUserTask);
  });

  test("Initial state should be empty", () {
    expect(userBloc.initialState, equals(EmptyUser()));
  });

  group("GetUsersTask test", () {
    test("should get users data from use case", () async {
      var actual = FakeUserService.getUserModel();
      when(mockGetUsersTask(NoParams())).thenAnswer((_) async => Right(actual));
      userBloc.add(GetUsersTaskEvent());
      await untilCalled(mockGetUsersTask(NoParams()));
      verify(mockGetUsersTask(NoParams())).called(1);
    });

    test("should emit [empty,loading,success] when getting users", () async {
      var actual = FakeUserService.getUserModel();
      when(mockGetUsersTask(NoParams())).thenAnswer((_) async => Right(actual));
      final expectedState = [
        EmptyUser(),
        LoadingUser(),
        SuccessUsers(usersList: actual)
      ];
      expectLater(userBloc, emitsInOrder(expectedState));
      userBloc.add(GetUsersTaskEvent());
    });

    test("should emit [empty,loading,error when getting users an exception",
        () async {
      var actual = ServerFailure();
      when(mockGetUsersTask(NoParams())).thenAnswer((_) async => Left(actual));
      final expectedState = [
        EmptyUser(),
        LoadingUser(),
        ErrorUser(message: ServerException.getServerErrorMessage)
      ];
      expectLater(userBloc, emitsInOrder(expectedState));
      userBloc.add(GetUsersTaskEvent());
    });
  });
  group("GetUserTask test", () {
    test("should get user with identifier from use case", () async {
      var actual = FakeUserService.getUserModel()[0];
      when(mockGetUserTask(USER_IDENTIFIER))
          .thenAnswer((_) async => Right(actual));
      userBloc.add(GetUserTaskEvent(identifier: USER_IDENTIFIER));
      await untilCalled(mockGetUserTask(USER_IDENTIFIER));
      verify(mockGetUserTask(USER_IDENTIFIER)).called(1);
    });

    test("should emit [empty,loading,user when getting user with identifier",
        () async {
      var actual = FakeUserService.getUserModel()[0];
      when(mockGetUserTask(USER_IDENTIFIER))
          .thenAnswer((_) async => Right(actual));
      final expectedState = [
        EmptyUser(),
        LoadingUser(),
        SuccessUser(userModel: actual)
      ];
      expectLater(userBloc, emitsInOrder(expectedState));
      userBloc.add(GetUserTaskEvent(identifier: USER_IDENTIFIER));
    });

    test(
        "should emit [empty,loading,error] when getting user with identifier cache error",
        () async {
      var actual = CacheFailure();
      when(mockGetUserTask(USER_IDENTIFIER))
          .thenAnswer((_) async => Left(actual));
      final expectedState = [
        EmptyUser(),
        LoadingUser(),
        ErrorUser(message: CacheException.getCacheErrorMessage)
      ];
      expectLater(userBloc, emitsInOrder(expectedState));
      userBloc.add(GetUserTaskEvent(identifier: USER_IDENTIFIER));
    });
  });
}
