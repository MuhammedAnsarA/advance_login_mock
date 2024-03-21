import 'package:advance_login_mock/core/error/exceptions.dart';
import 'package:advance_login_mock/core/error/failures.dart';
import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:advance_login_mock/features/onboarding/domain/repositories/onboarding_repo.dart';
import 'package:fpdart/fpdart.dart';

class OnboardingRepoImpl implements OnboardingRepo {
  final OnBoardingLocalDataSource _localDataSource;

  OnboardingRepoImpl(this._localDataSource);
  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return right(null);
    } on CacheException catch (e) {
      return left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return right(result);
    } on CacheException catch (e) {
      return left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
