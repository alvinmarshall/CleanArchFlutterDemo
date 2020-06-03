import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learncleanarch/domain/repository/i_user_repository.dart';
import 'package:learncleanarch/domain/usecase/base_usecase.dart';
import 'package:learncleanarch/domain/usecase/get_users_task.dart';
import 'package:mockito/mockito.dart';

import '../../utils/fake_user_service.dart';

class MockGetUserRepository extends Mock implements IUserRepository{
}

void main(){
  GetUsersTask getUsersTask;
  MockGetUserRepository mockGetUserRepository;
  setUp((){
    mockGetUserRepository  = MockGetUserRepository();
    getUsersTask = GetUsersTask(mockGetUserRepository);
  });

  test('should get users success', () async{
    var actual = FakeUserService.getUsers();
    when(mockGetUserRepository.getUsers()).thenAnswer((realInvocation) async => Right(actual) );
    final result = await getUsersTask.call(NoParams());
    result.fold((l) => null, (r) => print(r));
    verify(mockGetUserRepository.getUsers());
    verifyNoMoreInteractions(mockGetUserRepository);
  });
}