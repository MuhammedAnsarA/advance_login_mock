import 'dart:async';
import 'dart:io';

import 'package:advance_login_mock/core/enums/update_user.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';
import 'package:advance_login_mock/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:advance_login_mock/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:advance_login_mock/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:advance_login_mock/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:advance_login_mock/features/auth/domain/usecases/update_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUserUsecase _signInUserUsecase;
  final SignUpUserUsecase _signUpUserUsecase;
  final SignOutUsecase _signOutUsecase;
  final ForgotPasswordUsecase _forgotPasswordUsecase;
  final UpdateUserUsecase _updateUserUsecase;
  AuthBloc(
    SignInUserUsecase signInUserUsecase,
    SignUpUserUsecase signUpUserUsecase,
    SignOutUsecase signOutUsecase,
    ForgotPasswordUsecase forgotPasswordUsecase,
    UpdateUserUsecase updateUserUsecase,
  )   : _signInUserUsecase = signInUserUsecase,
        _signUpUserUsecase = signUpUserUsecase,
        _signOutUsecase = signOutUsecase,
        _forgotPasswordUsecase = forgotPasswordUsecase,
        _updateUserUsecase = updateUserUsecase,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });

    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
    on<SignOutEvent>(_signOutEventHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
    on<UpdateUserEvent>(_updateUserHandler);
  }

  Future<void> _signInHandler(
      SignInEvent event, Emitter<AuthState> emit) async {
    final result = await _signInUserUsecase.call(SignInParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _signUpHandler(
      SignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUpUserUsecase.call(SignUpParams(
      fullName: event.name,
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const SignedUp()),
    );
  }

  Future<void> _forgotPasswordHandler(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    final result = await _forgotPasswordUsecase.call(event.email);

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const ForgotPasswordSend()),
    );
  }

  Future<void> _updateUserHandler(
      UpdateUserEvent event, Emitter<AuthState> emit) async {
    final result = await _updateUserUsecase.call(UpdateUserParams(
      action: event.action,
      userData: event.userData,
    ));

    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const UserUpdated()),
    );
  }

  Future<void> _signOutEventHandler(
      SignOutEvent event, Emitter<AuthState> emit) async {
    final result = await _signOutUsecase.call();
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (_) => emit(const SignOutState()),
    );
  }
}
