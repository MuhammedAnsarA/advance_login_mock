import 'package:advance_login_mock/core/usecases/usecases.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/repositories/auth_repo.dart';

class SignOutUsecase extends FutureUsecaseWithoutParams<void> {
  final AuthRepo _repo;

  SignOutUsecase(this._repo);
  @override
  ResultFuture<void> call() async => _repo.signOut();
}
