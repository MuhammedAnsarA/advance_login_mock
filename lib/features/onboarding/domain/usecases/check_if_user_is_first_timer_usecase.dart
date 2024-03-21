import 'package:advance_login_mock/core/usecases/usecases.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/onboarding/domain/repositories/onboarding_repo.dart';

class CheckIfUserIsFirstTimerUsecase extends FutureUsecaseWithoutParams<bool> {
  final OnboardingRepo _repo;

  CheckIfUserIsFirstTimerUsecase(this._repo);
  @override
  ResultFuture<bool> call() async => _repo.checkIfUserIsFirstTimer();
}
