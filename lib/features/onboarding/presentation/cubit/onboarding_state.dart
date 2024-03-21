part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

class CachingFirstTimer extends OnboardingState {
  const CachingFirstTimer();
}

class CheckingIfUserIsFirstTimer extends OnboardingState {
  const CheckingIfUserIsFirstTimer();
}

class UserCashed extends OnboardingState {
  const UserCashed();
}

class OnboardingStatus extends OnboardingState {
  final bool isFirstTimer;

  const OnboardingStatus({required this.isFirstTimer});

  @override
  List<bool> get props => [isFirstTimer];
}

class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<String> get props => [message];
}
