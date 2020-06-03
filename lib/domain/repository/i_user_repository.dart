import 'package:dartz/dartz.dart';
import 'package:learncleanarch/domain/entities/user_entity.dart';
import 'package:learncleanarch/utils/failure.dart';

abstract class IUserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();

  Future<Either<Failure, UserEntity>> getUser(int identifier);
}
