import 'package:flutter/material.dart';

abstract class SignupEvent {}

class SignupInitialEvent extends SignupEvent {
  final BuildContext context;

  SignupInitialEvent(this.context);
}

class BackToSigninEvent extends SignupEvent {
  final BuildContext context;

  BackToSigninEvent(this.context);
}
