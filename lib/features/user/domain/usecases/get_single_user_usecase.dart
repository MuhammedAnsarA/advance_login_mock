import 'package:advance_login_mock/core/usecases/usecases.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';
import 'package:advance_login_mock/features/user/domain/repositories/user_repo.dart';

class GetSingleUserUsecase extends StreamUsecaseWithoutParams<List<LocalUser>> {
  final UserRepo _repo;

  GetSingleUserUsecase(this._repo);

  @override
  ResultStream<List<LocalUser>> call() => _repo.getSingleUser();
}
