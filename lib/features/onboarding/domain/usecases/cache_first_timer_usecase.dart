import 'package:advance_login_mock/core/usecases/usecases.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/onboarding/domain/repositories/onboarding_repo.dart';

class CacheFirstTimerUsecase extends FutureUsecaseWithoutParams<void> {
  const CacheFirstTimerUsecase(
    this._repo,
  );
  final OnboardingRepo _repo;

  @override
  ResultFuture<void> call() async => _repo.cacheFirstTimer();
}
