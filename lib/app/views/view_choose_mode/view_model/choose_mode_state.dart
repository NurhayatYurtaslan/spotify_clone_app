import 'package:flutter/material.dart';

// Tüm durumların temel sınıfı
abstract class ChooseModeState {}

// Başlangıç durumu
class ChooseModeInitialState extends ChooseModeState {
  final ThemeData themeData;

  ChooseModeInitialState(this.themeData);
}

// Temanın başarıyla değiştiği durum
class ChooseModeChangedState extends ChooseModeState {
  final ThemeData themeData;

  ChooseModeChangedState(this.themeData);
}

// Hata durumunu temsil eden sınıf
class ChooseModeErrorState extends ChooseModeState {
  final String error;

  ChooseModeErrorState(this.error);
}
