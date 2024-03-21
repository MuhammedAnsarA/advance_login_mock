import 'package:advance_login_mock/core/utils/typedefs.dart';

abstract class OnboardingRepo {
  const OnboardingRepo();

  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
