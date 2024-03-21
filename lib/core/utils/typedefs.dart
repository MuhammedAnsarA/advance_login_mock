import 'package:advance_login_mock/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultStream<T> = Stream<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
