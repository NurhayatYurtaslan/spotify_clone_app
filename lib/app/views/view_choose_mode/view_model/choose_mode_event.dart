import 'package:flutter/material.dart';

abstract class ChooseModeEvent {}

class ChooseModeInitialEvent extends ChooseModeEvent {
  final ThemeData themeData;

  ChooseModeInitialEvent(this.themeData);
}


class ChooseModeDarkEvent extends ChooseModeEvent {}

class ChooseModeLightEvent extends ChooseModeEvent {}
