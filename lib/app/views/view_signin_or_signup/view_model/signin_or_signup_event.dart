// Event'ler
import 'package:flutter/material.dart';

abstract class SigninOrSignupEvent {}

class NavigateToSigninEvent extends SigninOrSignupEvent {
  final BuildContext context; // Navigation için context alıyoruz
  NavigateToSigninEvent(this.context);
}

class NavigateToSignupEvent extends SigninOrSignupEvent {
  final BuildContext context;
  NavigateToSignupEvent(this.context);
}

class BackEvent extends SigninOrSignupEvent {
  final BuildContext context;
  BackEvent(this.context);
}
