import 'package:advance_login_mock/core/enums/update_user.dart';
import 'package:advance_login_mock/core/error/exceptions.dart';
import 'package:advance_login_mock/core/error/failures.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';
import 'package:advance_login_mock/features/auth/domain/repositories/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

import '../datasources/auth_remote_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepoImpl(this._remoteDataSource);

  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _remoteDataSource.signIn(email: email, password: password);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUp(
          fullName: fullName, email: email, password: password);
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _remoteDataSource.updateUser(action: action, userData: userData);
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
