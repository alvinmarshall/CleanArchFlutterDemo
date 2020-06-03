import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learncleanarch/utils/failure.dart';

abstract class BaseUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
