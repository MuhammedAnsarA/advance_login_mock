part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [name, email, password];
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
  @override
  List<Object> get props => [];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent(this.email);
  @override
  List<Object> get props => [email];
}

class UpdateUserEvent extends AuthEvent {
  final UpdateUserAction action;
  final dynamic userData;

  UpdateUserEvent({
    required this.action,
    required this.userData,
  }) : assert(
          userData is String || userData is File,
          '[userData] must be either a String or a File, but '
          'was ${userData.runtimeType}',
        );
  @override
  List<Object> get props => [action, userData];
}
