abstract class SigninState {}

class SigninInitialState extends SigninState {}

class SigninLoadingState extends SigninState {}

class SigninSuccessState extends SigninState {}

class SigninFailureState extends SigninState {
  final String errorMessage;
  SigninFailureState(this.errorMessage);
}