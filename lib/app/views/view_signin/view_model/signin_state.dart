// signin_state.dart
abstract class SigninState {}

class SigninInitialState extends SigninState {}

class SigninLoadingState extends SigninState {
  SigninLoadingState();
}

class SigninSuccessState extends SigninState {
  SigninSuccessState();
}

class SigninFailureState extends SigninState {
  final String message; // Eklenen message
  SigninFailureState(this.message);
}

class BackState extends SigninState {
  BackState();
}

class RegisterState extends SigninState {
  final String message;
  RegisterState(this.message);
}

class PasswordVisibilityState extends SigninState {
  final bool isVisible;
  PasswordVisibilityState(this.isVisible);
}
