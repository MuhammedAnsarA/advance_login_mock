import 'package:advance_login_mock/core/usecases/usecases.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignUpUserUsecase extends FutureUsecaseWithParams<void, SignUpParams> {
  final AuthRepo _repo;

  const SignUpUserUsecase(this._repo);

  @override
  ResultFuture<void> call(SignUpParams params) async {
    return await _repo.signUp(
      fullName: params.fullName,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  final String fullName;
  final String email;
  final String password;

  const SignUpParams({
    required this.fullName,
    required this.email,
    required this.password,
  });

  const SignUpParams.empty() : this(fullName: "", email: "", password: "");

  @override
  List<Object?> get props => [fullName, email, password];
}
