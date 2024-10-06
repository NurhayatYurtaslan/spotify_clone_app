import 'package:flutter/material.dart';

abstract class SigninEvent {}

class SigninInitialEvent extends SigninEvent {
  final BuildContext context;
  SigninInitialEvent(this.context);
}

class SigninWithGoogleEvent extends SigninEvent {
  final BuildContext context;
  SigninWithGoogleEvent(this.context);
}

class BackEvent extends SigninEvent {
  final BuildContext context;
  BackEvent(this.context);
}

class RegisterEvent extends SigninEvent {
  final BuildContext context;
  RegisterEvent(this.context);
}
