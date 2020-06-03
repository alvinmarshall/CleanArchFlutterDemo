import 'package:dartz/dartz.dart';
import 'package:learncleanarch/domain/entities/user_entity.dart';
import 'package:learncleanarch/domain/repository/i_user_repository.dart';
import 'package:learncleanarch/domain/usecase/base_usecase.dart';
import 'package:learncleanarch/utils/failure.dart';

class GetUserTask implements BaseUseCase<UserEntity, int> {
  IUserRepository _userRepository;

  GetUserTask(this._userRepository);

  @override
  Future<Either<Failure, UserEntity>> call(int params) async {
    return await _userRepository.getUser(params);
  }
}
