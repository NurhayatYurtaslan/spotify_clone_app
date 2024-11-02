import 'package:flutter/material.dart';

abstract class ChooseModeEvent {}

class ChooseModeInitialEvent extends ChooseModeEvent {
  final BuildContext context;
  ChooseModeInitialEvent(this.context);
}
