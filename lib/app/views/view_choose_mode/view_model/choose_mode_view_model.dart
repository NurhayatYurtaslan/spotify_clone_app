import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_event.dart';
import 'package:spotify_clone_app/app/views/view_choose_mode/view_model/choose_mode_state.dart';
import 'package:spotify_clone_app/core/theme/app_theme.dart';

class ChooseModeViewModel extends Bloc<ChooseModeEvent, ChooseModeState> {
  ThemeData currentTheme = AppTheme.lightTheme; // Default theme

  ChooseModeViewModel() : super(ChooseModeInitialState(AppTheme.lightTheme)) {
    on<ChooseModeInitialEvent>((event, emit) {
      currentTheme = event.themeData; // Update the current theme
      emit(ChooseModeChangedState(currentTheme));
    });
    on<ChooseModeDarkEvent>((event, emit) {
      currentTheme = AppTheme.darkTheme; // Set dark theme
      emit(ChooseModeChangedState(currentTheme));
    });
    on<ChooseModeLightEvent>((event, emit) {
      currentTheme = AppTheme.lightTheme; // Set light theme
      emit(ChooseModeChangedState(currentTheme));
    });
  }
}
