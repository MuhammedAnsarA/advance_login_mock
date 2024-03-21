import 'dart:async';

import 'package:advance_login_mock/core/error/failures.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';
import 'package:advance_login_mock/features/user/domain/usecases/get_all_users_usecase.dart';
import 'package:advance_login_mock/features/user/domain/usecases/get_single_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fpdart/fpdart.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUsecase _getAllUsersUsecase;
  final GetSingleUserUsecase _getSingleUserUsecase;
  UserCubit({
    required GetSingleUserUsecase getSingleUserUsecase,
    required GetAllUsersUsecase getAllUsersUsecase,
  })  : _getSingleUserUsecase = getSingleUserUsecase,
        _getAllUsersUsecase = getAllUsersUsecase,
        super(const UserInitial());

  void getAllUsers({required LocalUser users}) {
    emit(const UserLoading());

    StreamSubscription<Either<Failure, List<LocalUser>>>? subscription;

    subscription = _getAllUsersUsecase(users).listen(
      (result) {
        result.fold((failure) => emit(UserError(failure.errorMessage)),
            (users) => emit(GetAllUsersLoaded(users: users)));
      },
      onError: (dynamic error) {
        emit(UserError(error.toString()));
        subscription?.cancel();
      },
      onDone: () => subscription?.cancel(),
    );
  }

  void getSingleUser() {
    emit(const UserLoading());

    StreamSubscription<Either<Failure, List<LocalUser>>>? subscription;

    subscription = _getSingleUserUsecase().listen(
      (result) {
        result.fold((failure) => emit(UserError(failure.errorMessage)),
            (users) => emit(SingleUserLoaded(user: users.first)));
      },
      onError: (dynamic error) {
        emit(UserError(error.toString()));
        subscription?.cancel();
      },
      onDone: () => subscription?.cancel(),
    );
  }
}
