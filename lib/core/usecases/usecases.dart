import 'package:advance_login_mock/core/utils/typedefs.dart';

abstract class FutureUsecaseWithParams<Type, Params> {
  const FutureUsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class FutureUsecaseWithoutParams<Type> {
  const FutureUsecaseWithoutParams();

  ResultFuture<Type> call();
}

abstract class StreamUsecaseWithParams<Type, Params> {
  const StreamUsecaseWithParams();

  ResultStream<Type> call(Params params);
}

abstract class StreamUsecaseWithoutParams<Type> {
  const StreamUsecaseWithoutParams();

  ResultStream<Type> call();
}
