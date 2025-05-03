
abstract class LoginState {}

class LoginInitial extends LoginState {}

/// onBoarding states
class OnboardingPageChanged extends LoginState {}
class OnboardingCompleted extends LoginState {}
class OnboardingSkipped extends LoginState {} /// finished