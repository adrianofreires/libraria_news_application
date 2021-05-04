import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:libraria_news_application/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class Params<Type> extends Equatable {
  final dynamic params;

  Params({required this.params});

  @override
  List<Object?> get props => [params];
}
