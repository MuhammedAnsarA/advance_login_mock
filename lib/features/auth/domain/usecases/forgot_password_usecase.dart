import 'package:advance_login_mock/core/usecases/usecases.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/repositories/auth_repo.dart';

class ForgotPasswordUsecase extends FutureUsecaseWithParams<void, String> {
  final AuthRepo _repo;

  ForgotPasswordUsecase(this._repo);
  @override
  ResultFuture<void> call(String params) async =>
      await _repo.forgotPassword(params);
}
