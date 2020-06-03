import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncleanarch/domain/repository/i_user_repository.dart';
import 'package:learncleanarch/domain/usecase/get_user_task.dart';
import 'package:mockito/mockito.dart';

import '../../utils/fake_user_service.dart';

class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  MockUserRepository mockUserRepository;
  const int User_IDENTIFIER = 1;
  GetUserTask getUserTask;
  setUp(() {
    mockUserRepository = MockUserRepository();
    getUserTask = GetUserTask(mockUserRepository);
  });

  test("should get user with identifier success", () async {
    var actual = FakeUserService.getUsers()[0];
    when(mockUserRepository.getUser(User_IDENTIFIER))
        .thenAnswer((realInvocation) async => Right(actual));
    var result = await getUserTask(User_IDENTIFIER);
    result.fold((l) => null, (r) => print(r));
    verify(mockUserRepository.getUser(User_IDENTIFIER));
    verifyNoMoreInteractions(mockUserRepository);
  });
}
