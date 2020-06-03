import 'package:flutter_test/flutter_test.dart';
import 'package:learncleanarch/data/db/dao/user_dao.dart';
import 'package:learncleanarch/data/source/user_local_source.dart';
import 'package:mockito/mockito.dart';

import '../../utils/fake_user_service.dart';

class MockUserDao extends Mock implements UserDao {}

void main() {
  MockUserDao mockUserDao;
  UserLocalSourceImpl userLocalSourceImpl;
  const USER_IDENTIFIER = 1;
  setUp(() {
    mockUserDao = MockUserDao();
    userLocalSourceImpl = UserLocalSourceImpl(userDao: mockUserDao);
  });

  group("UserLocalSource test", () {
    test("should get user with identifier from cache", () async {
      var actual = FakeUserService.getUserModel()[0];
      when(mockUserDao.getUser(USER_IDENTIFIER))
          .thenAnswer((realInvocation) async => actual);
      var result = await userLocalSourceImpl.getUser(USER_IDENTIFIER);
      print(result);

      expect(actual, result);
      verify(mockUserDao.getUser(USER_IDENTIFIER)).called(1);
      verifyNoMoreInteractions(mockUserDao);
    });

    test("should get users from cache", () async {
      var actual = FakeUserService.getUserModel();
      when(mockUserDao.getUsers()).thenAnswer((_) async => actual);
      var result = await userLocalSourceImpl.getUsers();
      print(result);

      expect(actual, result);
      verify(mockUserDao.getUsers()).called(1);
      verifyNoMoreInteractions(mockUserDao);
    });

    test("should save users to cache", () async {
      var actual = FakeUserService.getUserModel();
      await userLocalSourceImpl.saveUsers(actual);
      verify(mockUserDao.addUser(actual[0]));
      verifyNoMoreInteractions(mockUserDao);
    });
  });
}
