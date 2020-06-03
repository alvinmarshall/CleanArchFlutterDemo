import 'package:flutter_test/flutter_test.dart';
import 'package:learncleanarch/data/repository/user_repository_impl.dart';
import 'package:learncleanarch/data/source/user_local_source.dart';
import 'package:learncleanarch/data/source/user_remote_source.dart';
import 'package:learncleanarch/utils/network_info.dart';
import 'package:mockito/mockito.dart';

import '../../utils/fake_user_service.dart';

class MockUserRemoteSource extends Mock implements IUserRemoteSource {}

class MockUserLocalSource extends Mock implements IUserLocalSource {}

class MockNetworkInfo extends Mock implements INetworkInfo {}

void main() {
  MockUserRemoteSource mockUserRemoteSource;
  MockUserLocalSource mockUserLocalSource;
  MockNetworkInfo mockNetworkInfo;
  UserRepositoryImpl userRepositoryImpl;
  final isConnected = true;
  const USER_IDENTIFIER = 1;

  setUp(() {
    mockUserRemoteSource = MockUserRemoteSource();
    mockUserLocalSource = MockUserLocalSource();
    mockNetworkInfo = MockNetworkInfo();

    userRepositoryImpl = UserRepositoryImpl(
        userRemoteSource: mockUserRemoteSource,
        userLocalSource: mockUserLocalSource,
        networkInfo: mockNetworkInfo);
  });

  group("network is connected", () {
    test("should fetch user with identifier success", () async {
      var actual = FakeUserService.getUserModel()[0];
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => isConnected);
      when(mockUserRemoteSource.fetchUser(USER_IDENTIFIER))
          .thenAnswer((_) async => (actual));
      var result = await userRepositoryImpl.getUser(USER_IDENTIFIER);
      result.fold((l) => null, (r) => print(r));

      verify(mockNetworkInfo.isConnected).called(1);
      verify(mockUserRemoteSource.fetchUser(USER_IDENTIFIER)).called(1);

      verifyNoMoreInteractions(mockNetworkInfo);
      verifyNoMoreInteractions(mockUserRemoteSource);
      verifyNoMoreInteractions(mockUserLocalSource);
    });

    test("should fetch users success", () async {
      var actual = FakeUserService.getUserModel();
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => isConnected);
      when(mockUserRemoteSource.fetchUsers()).thenAnswer((_) async => (actual));
      var result = await userRepositoryImpl.getUsers();
      result.fold((l) => null, (r) => print(r));

      verify(mockNetworkInfo.isConnected).called(1);
      verify(mockUserRemoteSource.fetchUsers()).called(1);
      verify(mockUserLocalSource.saveUsers(actual)).called(1);

      verifyNoMoreInteractions(mockNetworkInfo);
      verifyNoMoreInteractions(mockUserRemoteSource);
      verifyNoMoreInteractions(mockUserLocalSource);
    });
  });

  group("network offline", () {
    test("should get users from cache success", () async {
      var actual = FakeUserService.getUserModel();
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockUserRemoteSource.fetchUsers()).thenAnswer((_) async => actual);
      when(mockUserLocalSource.getUsers()).thenAnswer((_) async => actual);
      var result = await userRepositoryImpl.getUsers();
      result.fold((l) => null, (r) => print(r));

      verify(mockNetworkInfo.isConnected).called(1);
      verify(mockUserLocalSource.getUsers()).called(1);
      verifyNever(mockUserRemoteSource.fetchUsers());

      verifyNoMoreInteractions(mockNetworkInfo);
      verifyNoMoreInteractions(mockUserLocalSource);
      verifyNoMoreInteractions(mockUserRemoteSource);
    });

    test("should get user from cache success", () async {
      var actual = FakeUserService.getUserModel()[0];
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockUserRemoteSource.fetchUser(USER_IDENTIFIER))
          .thenAnswer((_) async => actual);
      when(mockUserLocalSource.getUser(USER_IDENTIFIER))
          .thenAnswer((_) async => actual);
      var result = await userRepositoryImpl.getUser(USER_IDENTIFIER);
      result.fold((l) => null, (r) => print(r));

      verify(mockNetworkInfo.isConnected).called(1);
      verify(mockUserLocalSource.getUser(USER_IDENTIFIER)).called(1);
      verifyNever(mockUserRemoteSource.fetchUser(USER_IDENTIFIER));

      verifyNoMoreInteractions(mockNetworkInfo);
      verifyNoMoreInteractions(mockUserLocalSource);
      verifyNoMoreInteractions(mockUserRemoteSource);
    });
  });
}
