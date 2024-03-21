import 'package:advance_login_mock/core/enums/update_user.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<void> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

  ResultFuture<void> signOut();
}
