import 'package:flutter/material.dart';

abstract class SignupEvent {}

class BackToSigninEvent extends SignupEvent {
  final BuildContext context;

  BackToSigninEvent(this.context);
}

class SignupInitialEvent extends SignupEvent {
  final BuildContext context;

  SignupInitialEvent(this.context);
}

class PasswordFocusEvent extends SignupEvent {
  final bool isFocused;

  PasswordFocusEvent(this.isFocused);
}

class TogglePasswordVisibilityEvent extends SignupEvent {}

class CheckPasswordRequirementsEvent extends SignupEvent {}

class BackEvent extends SignupEvent {
  final BuildContext context;
  
  BackEvent(this.context,);
}

class SigninEvent extends SignupEvent {
  final BuildContext context;
  final String message;

  SigninEvent(this.context,
      {this.message = 'Navigating to registration screen.'});
}