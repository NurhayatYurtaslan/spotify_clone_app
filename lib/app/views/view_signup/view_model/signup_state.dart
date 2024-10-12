abstract class SignupState {}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupFailureState extends SignupState {
  final String errorMessage;

  SignupFailureState(this.errorMessage);
}
class PasswordCriteriaVisibleState extends SignupState {
  final bool isVisible;
  PasswordCriteriaVisibleState(this.isVisible);
}

class BackState extends SignupState {
  BackState();
}

class SigninState extends SignupState {
  final String message;
  SigninState(this.message);
}