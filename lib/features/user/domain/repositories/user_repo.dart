import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';

abstract class UserRepo {
  const UserRepo();

  ResultStream<List<LocalUser>> getSingleUser();

  ResultStream<List<LocalUser>> getAllUsers(LocalUser user);
}
