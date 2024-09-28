import 'package:flutter/material.dart';

abstract class SplashEvent {}

class SplashInitialEvent extends SplashEvent {
  BuildContext context;
  SplashInitialEvent(this.context);
}
