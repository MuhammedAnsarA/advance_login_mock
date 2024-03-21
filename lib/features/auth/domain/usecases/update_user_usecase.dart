import 'package:advance_login_mock/core/enums/update_user.dart';
import 'package:advance_login_mock/core/usecases/usecases.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateUserUsecase
    extends FutureUsecaseWithParams<void, UpdateUserParams> {
  final AuthRepo _repo;

  UpdateUserUsecase(this._repo);
  @override
  ResultFuture<void> call(UpdateUserParams params) async {
    return await _repo.updateUser(
        action: params.action, userData: params.userData);
  }
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  const UpdateUserParams.empty()
      : this(action: UpdateUserAction.displayName, userData: '');

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}
