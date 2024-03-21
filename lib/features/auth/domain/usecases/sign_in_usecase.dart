import 'package:advance_login_mock/core/usecases/usecases.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';
import 'package:advance_login_mock/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignInUserUsecase
    extends FutureUsecaseWithParams<LocalUser, SignInParams> {
  final AuthRepo _repo;

  const SignInUserUsecase(this._repo);

  @override
  ResultFuture<LocalUser> call(SignInParams params) async {
    return await _repo.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty() : this(email: "", password: "");

  @override
  List<Object?> get props => [email, password];
}
