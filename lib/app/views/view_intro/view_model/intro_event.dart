import 'package:flutter/material.dart';

abstract class IntroEvent {}

class IntroInitialEvent extends IntroEvent {}

class GetStartedEvent extends IntroEvent {
  BuildContext context;
  GetStartedEvent(this.context);
}
