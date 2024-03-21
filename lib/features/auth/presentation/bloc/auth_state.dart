part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class SignedIn extends AuthState {
  final LocalUser user;

  const SignedIn(
    this.user,
  );
}

class SignedUp extends AuthState {
  const SignedUp();
}

class SignOutState extends AuthState {
  const SignOutState();
}

class ForgotPasswordSend extends AuthState {
  const ForgotPasswordSend();
}

class UserUpdated extends AuthState {
  const UserUpdated();
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
