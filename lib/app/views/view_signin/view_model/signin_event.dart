import 'package:flutter/material.dart';

abstract class SigninEvent {}

class BackEvent extends SigninEvent {
  final BuildContext context;
  
  BackEvent(this.context,);
}

class SigninInitialEvent extends SigninEvent {
  final BuildContext context; 
  final String email; 
  final String password; 

  SigninInitialEvent(this.context,
      {required this.email, required this.password});
}

class SigninWithGoogleEvent extends SigninEvent {
  final BuildContext context; 
  SigninWithGoogleEvent({required this.context});
}

class RegisterEvent extends SigninEvent {
  final BuildContext context;
  final String message;

  RegisterEvent(this.context,
      {this.message = 'Navigating to registration screen.'});
}

class TogglePasswordVisibilityEvent extends SigninEvent {}
