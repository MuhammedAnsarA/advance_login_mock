import 'dart:async';

import 'package:advance_login_mock/core/error/exceptions.dart';
import 'package:advance_login_mock/core/error/failures.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/data/model/user_model.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';
import 'package:advance_login_mock/features/user/domain/repositories/user_repo.dart';
import 'package:fpdart/fpdart.dart';

import '../datasources/user_remote_data_source.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource _remoteDataSource;

  const UserRepoImpl(this._remoteDataSource);
  @override
  ResultStream<List<LocalUser>> getAllUsers(LocalUser user) {
    return _remoteDataSource.getAllUsers(user).transform(StreamTransformer<
            List<LocalUserModel>,
            Either<Failure, List<LocalUser>>>.fromHandlers(
          handleError: (error, stackTrace, sink) {
            if (error is ServerException) {
              sink.add(
                left(
                  ServerFailure(
                      message: error.message, statusCode: error.statusCode),
                ),
              );
            } else {
              sink.add(
                left(
                  ServerFailure(message: error.toString(), statusCode: 500),
                ),
              );
            }
          },
          handleData: (getAllUsers, sink) {
            sink.add(right(getAllUsers));
          },
        ));
  }

  @override
  ResultStream<List<LocalUser>> getSingleUser() {
    return _remoteDataSource.getSingleUser().transform(StreamTransformer<
            List<LocalUserModel>,
            Either<Failure, List<LocalUser>>>.fromHandlers(
          handleError: (error, stackTrace, sink) {
            if (error is ServerException) {
              sink.add(
                Left(
                  ServerFailure(
                      message: error.message, statusCode: error.statusCode),
                ),
              );
            } else {
              sink.add(
                Left(
                  ServerFailure(message: error.toString(), statusCode: 500),
                ),
              );
            }
          },
          handleData: (getSingleUser, sink) {
            sink.add(Right(getSingleUser));
          },
        ));
  }
}
