import 'package:advance_login_mock/features/onboarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:advance_login_mock/features/onboarding/domain/usecases/check_if_user_is_first_timer_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final CacheFirstTimerUsecase _cacheFirstTimerUsecase;
  final CheckIfUserIsFirstTimerUsecase _checkIfUserIsFirstTimerUsecase;

  OnboardingCubit(
    CacheFirstTimerUsecase cacheFirstTimerUsecase,
    CheckIfUserIsFirstTimerUsecase checkIfUserIsFirstTimerUsecase,
  )   : _cacheFirstTimerUsecase = cacheFirstTimerUsecase,
        _checkIfUserIsFirstTimerUsecase = checkIfUserIsFirstTimerUsecase,
        super(const OnboardingInitial());

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimerUsecase();
    result.fold(
      (failure) => emit(OnboardingError(failure.errorMessage)),
      (_) => emit(const UserCashed()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimer());
    final result = await _checkIfUserIsFirstTimerUsecase();

    result.fold(
      (_) => emit(const OnboardingStatus(isFirstTimer: true)),
      (status) => emit(OnboardingStatus(isFirstTimer: status)),
    );
  }
}
