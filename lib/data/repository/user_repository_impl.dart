import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:learncleanarch/data/source/user_local_source.dart';
import 'package:learncleanarch/data/source/user_remote_source.dart';
import 'package:learncleanarch/domain/entities/user_entity.dart';
import 'package:learncleanarch/domain/repository/i_user_repository.dart';
import 'package:learncleanarch/utils/exception/exceptions.dart';
import 'package:learncleanarch/utils/failure.dart';
import 'package:learncleanarch/utils/network_info.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteSource userRemoteSource;
  final IUserLocalSource userLocalSource;
  final INetworkInfo networkInfo;

  UserRepositoryImpl(
      {@required this.userRemoteSource,
      @required this.userLocalSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, UserEntity>> getUser(int identifier) async {
    if (await networkInfo.isConnected) {
      try {
        var data = await userRemoteSource.fetchUser(identifier);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      var data = await userLocalSource.getUser(identifier);
      return Right(data);
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    if (await networkInfo.isConnected) {
      try {
        var data = await userRemoteSource.fetchUsers();
        userLocalSource.saveUsers(data);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      var data = await userLocalSource.getUsers();
      return Right(data);
    }
  }
}
