import 'package:advance_login_mock/core/usecases/usecases.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';
import 'package:advance_login_mock/features/user/domain/repositories/user_repo.dart';

class GetAllUsersUsecase
    extends StreamUsecaseWithParams<List<LocalUser>, LocalUser> {
  final UserRepo _repo;

  const GetAllUsersUsecase(this._repo);
  @override
  ResultStream<List<LocalUser>> call(LocalUser params) =>
      _repo.getAllUsers(params);
}
