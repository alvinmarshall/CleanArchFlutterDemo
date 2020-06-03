import 'package:dartz/dartz.dart';
import 'package:learncleanarch/domain/entities/user_entity.dart';
import 'package:learncleanarch/domain/repository/i_user_repository.dart';
import 'package:learncleanarch/domain/usecase/base_usecase.dart';
import 'package:learncleanarch/utils/failure.dart';

class GetUsersTask implements BaseUseCase<List<UserEntity>,NoParams>{
  final IUserRepository _userRepository;

  GetUsersTask(this._userRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await _userRepository.getUsers();
  }


}